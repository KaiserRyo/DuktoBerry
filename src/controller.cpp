/*
 * controller.cpp
 *
 *  Created on: 03/04/2014
 *      Author: laairoy
 */

#include "controller.h"
#include "protocol/platform.h"

#define NETWORK_PORT 4644

controller::controller() :
		QObject(NULL), mDestBuddy(NULL), mSettings(NULL) {
	// TODO Auto-generated constructor stub
	m_buddyModel = new BuddyModel();

	// Destination buddy
	mDestBuddy = new DestinationBuddy(this);

	setCurrentTransferProgress(0);

	// Settings
	mSettings = new Settings(this);

	workingDir = QDir::currentPath();
	connect(&mDuktoProtocol, SIGNAL(peerListAdded(Peer)), this, SLOT(peerListAdded(Peer)));
	connect(&mDuktoProtocol, SIGNAL(peerListRemoved(Peer)), this, SLOT(peerListRemoved(Peer)));
	connect(&mDuktoProtocol, SIGNAL(transferStatusUpdate(qint64,qint64)), this, SLOT(transferStatusUpdate(qint64,qint64)));

	// Periodic "hello" timer
	mPeriodicHelloTimer = new QTimer(this);
	connect(mPeriodicHelloTimer, SIGNAL(timeout()), this,
			SLOT(periodicHello()));
	mPeriodicHelloTimer->start(60000);

}

controller::~controller() {
	// TODO Auto-generated destructor stub
}

void controller::sendSomeFiles(QVariant indexPath, QStringList files) {
	if (files.count() == 0)
		return;
	QVariantMap item = indexPath.toMap();
	mDestBuddy->fillFromItem(item);
	//Send files
	QStringList toSend = files;
	startTransfer(toSend);
}

void controller::periodicHello() {
	mDuktoProtocol.sayHello(QHostAddress::Broadcast);
}

void controller::peerListAdded(Peer peer) {
	// Add user in model
	m_buddyModel->addBuddy(peer);
}

void controller::initialize() {
	// Say "hello"
	mDuktoProtocol.initialize();
	mDuktoProtocol.setPorts(NETWORK_PORT, NETWORK_PORT);
	mDuktoProtocol.sayHello(QHostAddress::Broadcast);

}

bb::cascades::GroupDataModel* controller::buddyModel() {
	return m_buddyModel;
}

bool controller::prepareStartTransfer(QString* ip, qint16* port) {
//	// Check if it's a remote file transfer
//	if (mDestBuddy->ip() == "IP") {
//
//		// Remote transfer
//		QString dest = remoteDestinationAddress();
//
//		// Check if port is specified
//		if (dest.contains(":")) {
//
//			// Port is specified or destination is malformed...
//			QRegExp rx("^(.*):([0-9]+)$");
//			if (rx.indexIn(dest) == -1) {
//
//				// Malformed destination
////				setMessagePageTitle("Send");
////				setMessagePageText(
////						"Hey, take a look at your destination, it appears to be malformed!");
////				setMessagePageBackState("send");
////				emit gotoMessagePage();
//				return false;
//			}
//
//			// Get IP (or hostname) and port
//			QStringList capt = rx.capturedTexts();
//			*ip = capt[1];
//			*port = capt[2].toInt();
//		} else {
//
//			// Port not specified, using default
//			*ip = dest;
//			*port = 0;
//		}
////		setCurrentTransferBuddy(*ip);
//	} else {
//
//		// Local transfer
//		*ip = mDestBuddy->ip();
//		*port = mDestBuddy->port();
////		setCurrentTransferBuddy(mDestBuddy->username());
//	}
//
//	// Update GUI for file transfer
////	setCurrentTransferSending(true);
////	setCurrentTransferStats("Connecting...");
////	setCurrentTransferProgress(0);
//	//    mView->win7()->setProgressState(EcWin7::Normal);
//	//    mView->win7()->setProgressValue(0, 100);
//
////	emit transferStart();
//	return true;
}

void controller::startTransfer(QStringList files) {
	// Prepare file transfer
	QString ip = mDestBuddy->ip();
	qint16 port = mDestBuddy->port();
//	if (!prepareStartTransfer(&ip, &port))
//		return;

// Start files transfer
	mDuktoProtocol.sendFile(ip, port, files);
}

void controller::peerListRemoved(Peer peer) {
	// Remove from the list
	m_buddyModel->removeBuddy(peer.address.toString());
	emit onBuddyModelChanged();
}

int controller::currentTransferProgress() {
	return mCurrentTransferProgress;
}

void controller::setCurrentTransferProgress(int value) {
	if (value == mCurrentTransferProgress) return;
	    mCurrentTransferProgress = value;
	    qDebug() << "controller::setCurrentTransferProgress:" << value;
	    emit currentTransferProgressChanged();
}

void controller::transferStatusUpdate(qint64 total, qint64 partial) {
	// Stats formatting
	if (total < 1024)
		setCurrentTransferStats(
				QString::number(partial) + " B of " + QString::number(total)
						+ " B");
	else if (total < 1048576)
		setCurrentTransferStats(
				QString::number(partial * 1.0 / 1024, 'f', 1) + " KB of "
						+ QString::number(total * 1.0 / 1024, 'f', 1) + " KB");
	else
		setCurrentTransferStats(
				QString::number(partial * 1.0 / 1048576, 'f', 1) + " MB of "
						+ QString::number(total * 1.0 / 1048576, 'f', 1)
						+ " MB");

	double percent = partial * 1.0 / total * 100;
	setCurrentTransferProgress(percent);
}

QString controller::currentTransferStats() {
	return mCurrentTransferStats;
}

void controller::setCurrentTransferStats(QString stats) {
	if (stats == mCurrentTransferStats) return;
	mCurrentTransferStats = stats;
	emit currentTransferStatsChanged();
}

void controller::setBuddyName(QString name) {
	mSettings->saveBuddyName(name.replace(' ', ""));
	mDuktoProtocol.updateBuddyName();
	m_buddyModel->updateMeElement();
	emit buddyNameChanged();
}

QString controller::buddyName() {
	return mSettings->buddyName();
}

void controller::setBuddyAvatar(QString avatar) {
	mSettings->saveBuddyAvatar(avatar);
	emit buddyAvatarChanged();
}

QString controller::buddyAvatar() {
	return mSettings->buddyAvatar();
}

void controller::setThemeColor(QString color) {
	mSettings->saveThemeColor(color);
		emit themeColorChanged();
}

QString controller::themeColor() {
	return mSettings->themeColor();
}

void controller::startTransfer(QString text) {
	// Prepare file transfer
	QString ip = mDestBuddy->ip();
	qint16 port = mDestBuddy->port();
//	if (!prepareStartTransfer(&ip, &port))
//		return;

// Start files transfer
	mDuktoProtocol.sendText(ip, port, text);
}
