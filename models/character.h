#ifndef H_EM_CHARACTER
#define H_EM_CHARACTER

#include <QString>
#include <QObject>
#include "eve_api/eve_api_tokens.h"
#include "update_timestamps.h"


class QDataStream;


namespace EM {


class Character: public QObject
{
    Q_OBJECT
    // to allow QML bindings
    // general info
    Q_PROPERTY(quint64   characterId        READ characterId        NOTIFY characterIdChanged)
    Q_PROPERTY(QString   characterName      READ characterName      NOTIFY characterNameChanged)
    Q_PROPERTY(quint64   corporationId      READ corporationId      NOTIFY corporationIdChanged)
    Q_PROPERTY(QString   corporationName    READ corporationName    NOTIFY corporationNameChanged)
    Q_PROPERTY(QString   corporationTicker  READ corporationTicker  NOTIFY corporationTickerChanged)
    Q_PROPERTY(quint64   allianceId         READ allianceId         NOTIFY allianceIdChanged)
    Q_PROPERTY(QString   allianceName       READ allianceName       NOTIFY allianceNameChanged)
    Q_PROPERTY(QString   allianceTicker     READ allianceTicker     NOTIFY allianceTickerChanged)
    Q_PROPERTY(QString   raceName           READ raceName           NOTIFY raceNameChanged)
    Q_PROPERTY(QString   ancestryName       READ ancestryName       NOTIFY ancestryNameChanged)
    Q_PROPERTY(QString   bloodlineName      READ bloodlineName      NOTIFY bloodlineNameChanged)
    Q_PROPERTY(int       gender             READ gender             NOTIFY genderChanged)
    Q_PROPERTY(QDateTime birthday           READ birthday           NOTIFY birthdayChanged)
    Q_PROPERTY(float     securityStatus     READ securityStatus     NOTIFY securityStatusChanged)
    Q_PROPERTY(QString   securityStatusStr  READ securityStatusStr  NOTIFY securityStatusChanged)
    Q_PROPERTY(QString   bio                READ bio                NOTIFY bioChanged)
    // wallet info
    Q_PROPERTY(float     iskAmount          READ iskAmount          NOTIFY iskAmountChanged)
    Q_PROPERTY(QString   iskAmountStr       READ iskAmountStr       NOTIFY iskAmountChanged)
    // location info
    Q_PROPERTY(quint64   currentSolarSystemId       READ currentSolarSystemId       NOTIFY currentSolarSystemChanged)
    Q_PROPERTY(QString   currentSolarSystemName     READ currentSolarSystemName     NOTIFY currentSolarSystemChanged)
    Q_PROPERTY(float     currentSolarSystemSecurity READ currentSolarSystemSecurity NOTIFY currentSolarSystemSecurityChanged)
    Q_PROPERTY(QString   currentSolarSystemSecurityStr READ currentSolarSystemSecurityStr NOTIFY currentSolarSystemSecurityChanged)
    Q_PROPERTY(quint64   currentConstellationId     READ currentConstellationId     NOTIFY currentConstellationChanged)
    Q_PROPERTY(QString   currentConstellationName   READ currentConstellationName   NOTIFY currentConstellationChanged)
    Q_PROPERTY(quint64   currentRegionId            READ currentRegionId            NOTIFY currentRegionChanged)
    Q_PROPERTY(QString   currentRegionName          READ currentRegionName          NOTIFY currentRegionChanged)
    Q_PROPERTY(quint64   currentStationId           READ currentStationId           NOTIFY isDockedChanged)
    Q_PROPERTY(quint64   currentStructureId         READ currentStructureId         NOTIFY isDockedChanged)
    Q_PROPERTY(QString   currentStructureName       READ currentStructureName       NOTIFY isDockedChanged)
    Q_PROPERTY(bool      isDocked                   READ isDocked                   NOTIFY isDockedChanged)
    Q_PROPERTY(quint64   currentShipTypeId          READ currentShipTypeId          NOTIFY currentShipChanged)
    Q_PROPERTY(QString   currentShipTypeName        READ currentShipTypeName        NOTIFY currentShipChanged)
    Q_PROPERTY(QString   currentShipFriendlyName    READ currentShipFriendlyName    NOTIFY currentShipChanged)

public:
    Character();
    Character(const Character& other);
    Character& operator=(const Character& other);
    bool operator==(const Character& other);

    QString toString() const;

public:
    quint64 characterId() const;
    void setCharacterId(quint64 char_id);

    QString characterName() const;
    void setCharacterName(const QString& name);

    quint64 corporationId() const;
    void setCorporationId(quint64 corp_id);

    QString corporationName() const;
    void setCorporationName(const QString& corp_name);

    QString corporationTicker() const;
    void setCorporationTicker(const QString& ticker);

    quint64 allianceId() const;
    void setAllianceId(quint64 ally_id);

    QString allianceName() const;
    void setAllianceName(const QString& ally_name);

    QString allianceTicker() const;
    void setAllianceTicker(const QString& ticker);

    quint64 raceId() const;
    void setRaceId(quint64 race_id);

    QString raceName() const;
    void setRaceName(const QString& race_name);

    quint64 ancestryId() const;
    void setAncestryId(quint64 id);

    QString ancestryName() const;
    void setAncestryName(const QString& name);

    quint64 bloodlineId() const;
    void setBloodlineId(quint64 id);

    QString bloodlineName() const;
    void setBloodlineName(const QString& name);

    int gender() const;  // 0 - male
    void setGender(int g);

    QDateTime birthday() const;
    void setBirthday(const QDateTime& dt);

    float securityStatus() const;
    QString securityStatusStr() const;
    void setSecurityStatus(float ss);

    QString bio() const;
    void setBio(const QString& s);

    // wallet info
    float iskAmount() const;
    QString iskAmountStr() const;
    void setIskAmount(float isk);

    // location info
    quint64 currentSolarSystemId() const;
    void setCurrentSolarSystemId(quint64 id);

    QString currentSolarSystemName() const;
    void setCurrentSolarSystemName(const QString& name);

    float currentSolarSystemSecurity() const;
    QString currentSolarSystemSecurityStr() const;
    void setCurrentSolarSystemSecurity(float ss);

    quint64 currentConstellationId() const;
    void setCurrentConstellationId(quint64 id);

    QString currentConstellationName() const;
    void setCurrentConstellationName(const QString& name);

    quint64 currentRegionId() const;
    void setCurrentRegionId(quint64 id);

    QString currentRegionName() const;
    void setCurrentRegionName(const QString& name);

    quint64 currentStationId() const;
    void setCurrentStationId(quint64 id);

    quint64 currentStructureId() const;
    void setCurrentStructureId(quint64 id);

    QString currentStructureName() const;
    void setCurrentStructureName(const QString& name);

    bool    isDocked() const;

    quint64 currentShipTypeId() const;
    void setCurrentShipTypeId(quint64 id);

    QString currentShipTypeName() const;
    void setCurrentShipTypeName(const QString& name);

    QString currentShipFriendlyName() const;
    void setCurrentShipFriendlyName(const QString& name);

    // auth info
    EveOAuthTokens getAuthTokens() const;
    void setAuthTokens(const EveOAuthTokens& tokens);

    UpdateTimestamps updateTimestamps() const;
    void setUpdateTimestamps(const UpdateTimestamps& ts);
    void setUpdateTimestamp(UpdateTimestamps::UTST kind);

Q_SIGNALS:
    // general info
    void characterIdChanged();
    void characterNameChanged();
    void corporationIdChanged();
    void corporationNameChanged();
    void corporationTickerChanged();
    void allianceIdChanged();
    void allianceNameChanged();
    void allianceTickerChanged();
    void raceNameChanged();
    void ancestryNameChanged();
    void bloodlineNameChanged();
    void genderChanged();
    void birthdayChanged();
    void securityStatusChanged();
    void bioChanged();
    // wallet info
    void iskAmountChanged();
    // location info
    void currentSolarSystemChanged();
    void currentSolarSystemSecurityChanged();
    void currentConstellationChanged();
    void currentRegionChanged();
    void isDockedChanged();
    void currentShipChanged();

protected:
    // general info
    quint64   m_characterId;
    QString   m_characterName;
    quint64   m_corporationId;
    QString   m_corporationName;
    QString   m_corporationTicker;
    quint64   m_allianceId;
    QString   m_allianceName;
    QString   m_allianceTicker;
    // general - origins
    quint64   m_raceId;
    QString   m_raceName;
    quint64   m_ancestryId;
    QString   m_ancestryName;
    quint64   m_bloodlineId;
    QString   m_bloodlineName;
    int       m_gender;  // 0 - male
    QDateTime m_birthday_dt;
    float     m_securityStatus;
    QString   m_bio;

    // wallet info
    float     m_isk;

    // location info
    quint64   m_currentSolarSystemId;
    QString   m_currentSolarSystemName;
    float     m_currentSolarSystemSecurity;
    quint64   m_currentConstellationId;
    QString   m_currentConstellationName;
    quint64   m_currentRegionId;
    QString   m_currentRegionName;
    // location - station
    quint64   m_currentStationId;
    quint64   m_currentStructureId;
    QString   m_currentStructureName;
    // location - ship
    quint64   m_currentShipTypeId;
    QString   m_currentShipTypeName;
    QString   m_currentShipFriendlyName;

    // auth info
    EveOAuthTokens m_tokens;

    // last update date-times
    UpdateTimestamps m_update_timestamps;
};


} // namespace


// serializing functions
QDataStream& operator<<(QDataStream& stream, const EM::Character& character);
QDataStream& operator>>(QDataStream& stream, EM::Character& character);


#endif