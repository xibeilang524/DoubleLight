#ifndef QMLLANGUAGE_H
#define QMLLANGUAGE_H

#include <QObject>
#include <QTranslator>
#include <QGuiApplication>
#include <QQmlApplicationEngine>

class QmlLanguage : public QObject
{
    Q_OBJECT
public:
    QmlLanguage(QGuiApplication& app, QQmlApplicationEngine &engine);

    Q_INVOKABLE void setLanguage(int nLanguage);

signals:
    void signal_languageChange(int);
private:
    QTranslator ch_t;
    QTranslator en_t;
    QGuiApplication *m_app;
    QQmlApplicationEngine *m_engine;
};

#endif // QMLLANGUAGE_H
