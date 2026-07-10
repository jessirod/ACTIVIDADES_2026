CREATE DATABASE LINK PCPHQ_DBLINK
    CONNECT TO PCP
    IDENTIFIED BY "PCPH_163pcp"
    USING '(DESCRIPTION =
        (ADDRESS = (PROTOCOL = TCP)(HOST = LX010QSCAN)(PORT = 1560))
        (TRANSPORT_CONNECT_TIMEOUT=3)
        (RETRY_COUNT=6)
        (LOAD_BALANCE = on)
        (FAILOVER=on)
        (CONNECT_DATA =
            (SERVER = DEDICATED)
            (SERVICE_NAME = PCPHQ_APP)
            (FAILOVER_MODE =
                (TYPE = select)
                (METHOD = basic)
            )
        )
    )';
