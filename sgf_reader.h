#pragma once

#include <QObject>

class sgf_reader : public QObject
{
    Q_OBJECT
public:
    explicit sgf_reader(QObject *parent = nullptr);

private:
    void recogniteSGF();
    QList<QList<int>> boardMatrixIdentity;
signals:

};
