#pragma once

#include <QObject>
#include <qqml.h>
#include <QString>
#include <QSet>


class GoBoard : public QObject {
    Q_OBJECT
    //QML_ELEMENT

public:
    explicit GoBoard(QObject *parent = nullptr);
    ~GoBoard();

private:
    int currentColor;
    QSet<int> currentGroup;
    bool killedStoneFlag, damezumariFlag, selfDestructFlag;
    int imaginaryKoIndex, koPosition = -10, suicideFlag = 0, mindedIndex = -10, currentPosition = -10, moves = 0, oneStoneFlag = 0;

    void identifyGroup(QList<QList<int>>, const int &, const int &, const int &, const int &, int &);
    void checkNearestGroup(QList<QList<int>> & array, const int &positionX, const int &positionY, const int & index, const int & color);
    bool isNearStonesKilled(QList<QList<int>> & array, const int &positionX, const int &positionY, const int & index, const int & color);

public slots:
    void makeRules(QList<QList<int>>, const int &, const int &, const int &, int);

signals:
    void deleteStone(const int &);
    void updateCaptiveStones(const int &, const int &, const int &, const int &);
    void getBackMove();
};


