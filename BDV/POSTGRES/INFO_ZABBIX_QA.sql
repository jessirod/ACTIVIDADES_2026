ZABBIX - CALIDAD

-Versión de la BD PSQL

 PostgreSQL 15.5


-Tamaño de las tablas de la BD llamada: zabbix

Tamaño BD - 15 GB

Tamaño Tablas

 schemaname |         table_name         | total_size | table_size | index_size
------------+----------------------------+------------+------------+------------
 public     | history                    | 10 GB      | 379 MB     | 10063 MB
 public     | history_text               | 2526 MB    | 598 MB     | 35 MB
 public     | trends                     | 1379 MB    | 863 MB     | 515 MB
 public     | history_uint               | 790 MB     | 488 MB     | 302 MB
 public     | trends_uint                | 282 MB     | 187 MB     | 95 MB
 public     | history_log                | 55 MB      | 28 MB      | 27 MB
 public     | alerts                     | 52 MB      | 31 MB      | 21 MB
 public     | event_tag                  | 22 MB      | 13 MB      | 8976 kB
 public     | items                      | 22 MB      | 14 MB      | 7696 kB
 public     | events                     | 19 MB      | 9184 kB    | 10 MB
 public     | history_str                | 10152 kB   | 6888 kB    | 3232 kB
 public     | auditlog                   | 7048 kB    | 5384 kB    | 1624 kB
 public     | valuemap_mapping           | 4544 kB    | 2192 kB    | 2320 kB
 public     | event_recovery             | 4320 kB    | 1856 kB    | 2432 kB
 public     | item_preproc               | 3848 kB    | 2544 kB    | 1248 kB
 public     | triggers                   | 3160 kB    | 2480 kB    | 640 kB
 public     | item_tag                   | 3000 kB    | 1720 kB    | 1240 kB
 public     | changelog                  | 2880 kB    | 8192 bytes | 2840 kB
 public     | item_discovery             | 2872 kB    | 1496 kB    | 1336 kB
 public     | functions                  | 1720 kB    | 696 kB     | 992 kB
 public     | item_rtdata                | 1400 kB    | 1120 kB    | 240 kB
 public     | hostmacro                  | 1256 kB    | 688 kB     | 528 kB
 public     | images                     | 1184 kB    | 80 kB      | 32 kB
 public     | trigger_tag                | 1016 kB    | 536 kB     | 440 kB
 public     | widget_field               | 888 kB     | 248 kB     | 600 kB
 public     | graphs_items               | 832 kB     | 408 kB     | 392 kB
 public     | ha_node                    | 776 kB     | 368 kB     | 368 kB
 public     | hosts                      | 664 kB     | 408 kB     | 200 kB
 public     | graphs                     | 656 kB     | 344 kB     | 280 kB
 public     | housekeeper                | 496 kB     | 8192 bytes | 472 kB
 public     | profiles                   | 480 kB     | 160 kB     | 280 kB
 public     | item_condition             | 424 kB     | 256 kB     | 136 kB
 public     | problem_tag                | 400 kB     | 8192 bytes | 352 kB
 public     | problem                    | 376 kB     | 16 kB      | 320 kB
 public     | trigger_discovery          | 352 kB     | 240 kB     | 80 kB
 public     | trigger_depends            | 336 kB     | 96 kB      | 208 kB
 public     | valuemap                   | 288 kB     | 120 kB     | 136 kB
 public     | widget                     | 232 kB     | 112 kB     | 80 kB
 public     | media_type                 | 208 kB     | 24 kB      | 32 kB
 public     | host_tag                   | 176 kB     | 64 kB      | 80 kB
 public     | lld_macro_path             | 168 kB     | 56 kB      | 80 kB
 public     | media_type_param           | 136 kB     | 56 kB      | 48 kB
 public     | media_type_message         | 128 kB     | 64 kB      | 32 kB
 public     | graph_discovery            | 128 kB     | 64 kB      | 32 kB
 public     | item_parameter             | 120 kB     | 40 kB      | 48 kB
 public     | hosts_groups               | 112 kB     | 24 kB      | 64 kB
 public     | sysmaps_elements           | 112 kB     | 8192 bytes | 96 kB
 public     | dashboard                  | 112 kB     | 40 kB      | 48 kB
 public     | acknowledges               | 112 kB     | 16 kB      | 64 kB
 public     | interface                  | 112 kB     | 8192 bytes | 64 kB
 public     | escalations                | 104 kB     | 8192 bytes | 64 kB
 public     | sysmaps                    | 96 kB      | 8192 bytes | 80 kB
 public     | config                     | 96 kB      | 8192 bytes | 80 kB
 public     | event_suppress             | 88 kB      | 8192 bytes | 80 kB
 public     | sessions                   | 80 kB      | 16 kB      | 32 kB
 public     | dashboard_page             | 80 kB      | 24 kB      | 32 kB
 public     | httptest                   | 80 kB      | 8192 bytes | 64 kB
 public     | lld_override               | 80 kB      | 16 kB      | 32 kB
 public     | scripts                    | 80 kB      | 8192 bytes | 64 kB
 public     | role_rule                  | 80 kB      | 8192 bytes | 64 kB
 public     | sysmaps_links              | 80 kB      | 8192 bytes | 64 kB
 public     | users                      | 80 kB      | 8192 bytes | 64 kB
 public     | lld_override_operation     | 72 kB      | 16 kB      | 32 kB
 public     | lld_override_condition     | 72 kB      | 16 kB      | 32 kB
 public     | group_prototype            | 72 kB      | 8192 bytes | 64 kB
 public     | actions                    | 64 kB      | 8192 bytes | 48 kB
 public     | drules                     | 64 kB      | 8192 bytes | 48 kB
 public     | task                       | 64 kB      | 0 bytes    | 48 kB
 public     | httpstepitem               | 56 kB      | 8192 bytes | 48 kB
 public     | opmessage_grp              | 56 kB      | 8192 bytes | 48 kB
 public     | task_acknowledge           | 56 kB      | 8192 bytes | 16 kB
 public     | sysmaps_link_triggers      | 56 kB      | 8192 bytes | 48 kB
 public     | opcommand_hst              | 56 kB      | 8192 bytes | 48 kB
 public     | host_rtdata                | 56 kB      | 8192 bytes | 16 kB
 public     | usrgrp                     | 56 kB      | 8192 bytes | 48 kB
 public     | optemplate                 | 56 kB      | 8192 bytes | 48 kB
 public     | httptestitem               | 56 kB      | 8192 bytes | 48 kB
 public     | dashboard_usrgrp           | 56 kB      | 8192 bytes | 48 kB
 public     | ids                        | 56 kB      | 8192 bytes | 16 kB
 public     | lld_override_optemplate    | 56 kB      | 8192 bytes | 48 kB
 public     | opgroup                    | 56 kB      | 8192 bytes | 48 kB
 public     | users_groups               | 56 kB      | 8192 bytes | 48 kB
 public     | host_discovery             | 56 kB      | 8192 bytes | 48 kB
 public     | hosts_templates            | 56 kB      | 8192 bytes | 48 kB
 public     | task_check_now             | 56 kB      | 8192 bytes | 16 kB
 public     | conditions                 | 48 kB      | 8192 bytes | 32 kB
 public     | lld_override_optag         | 48 kB      | 8192 bytes | 32 kB
 public     | regexps                    | 48 kB      | 8192 bytes | 32 kB
 public     | httpstep_field             | 48 kB      | 8192 bytes | 32 kB
 public     | dchecks                    | 48 kB      | 8192 bytes | 32 kB
 public     | token                      | 48 kB      | 0 bytes    | 40 kB
 public     | httpstep                   | 48 kB      | 8192 bytes | 32 kB
 public     | opmessage                  | 48 kB      | 8192 bytes | 32 kB
 public     | config_autoreg_tls         | 48 kB      | 8192 bytes | 32 kB
 public     | globalmacro                | 48 kB      | 8192 bytes | 32 kB
 public     | sysmap_shape               | 48 kB      | 8192 bytes | 32 kB
 public     | role                       | 40 kB      | 8192 bytes | 32 kB
 public     | report                     | 40 kB      | 0 bytes    | 32 kB
 public     | expressions                | 40 kB      | 8192 bytes | 32 kB
 public     | opcommand                  | 40 kB      | 8192 bytes | 32 kB
 public     | hstgrp                     | 40 kB      | 8192 bytes | 32 kB
 public     | graph_theme                | 40 kB      | 8192 bytes | 32 kB
 public     | operations                 | 40 kB      | 8192 bytes | 32 kB
 public     | userdirectory_usrgrp       | 32 kB      | 0 bytes    | 32 kB
 public     | media                      | 32 kB      | 0 bytes    | 24 kB
 public     | report_usrgrp              | 32 kB      | 0 bytes    | 32 kB
 public     | dservices                  | 32 kB      | 0 bytes    | 24 kB
 public     | maintenances               | 32 kB      | 0 bytes    | 24 kB
 public     | autoreg_host               | 32 kB      | 0 bytes    | 24 kB
 public     | host_inventory             | 32 kB      | 8192 bytes | 16 kB
 public     | tag_filter                 | 32 kB      | 0 bytes    | 24 kB
 public     | module                     | 32 kB      | 8192 bytes | 16 kB
 public     | proxy_dhistory             | 32 kB      | 0 bytes    | 24 kB
 public     | task_data                  | 32 kB      | 8192 bytes | 16 kB
 public     | report_user                | 32 kB      | 0 bytes    | 32 kB
 public     | correlation                | 32 kB      | 0 bytes    | 24 kB
 public     | task_result                | 24 kB      | 0 bytes    | 16 kB
 public     | sysmap_url                 | 24 kB      | 0 bytes    | 16 kB
 public     | script_param               | 24 kB      | 0 bytes    | 16 kB
 public     | sysmap_user                | 24 kB      | 0 bytes    | 24 kB
 public     | userdirectory_idpgroup     | 24 kB      | 0 bytes    | 24 kB
 public     | maintenances_groups        | 24 kB      | 0 bytes    | 24 kB
 public     | icon_map                   | 24 kB      | 0 bytes    | 24 kB
 public     | sla                        | 24 kB      | 0 bytes    | 16 kB
 public     | lld_override_opstatus      | 24 kB      | 8192 bytes | 16 kB
 public     | maintenances_windows       | 24 kB      | 0 bytes    | 24 kB
 public     | connector_tag              | 24 kB      | 0 bytes    | 16 kB
 public     | sysmap_element_url         | 24 kB      | 0 bytes    | 16 kB
 public     | connector                  | 24 kB      | 0 bytes    | 16 kB
 public     | service_tag                | 24 kB      | 0 bytes    | 16 kB
 public     | service_problem            | 24 kB      | 0 bytes    | 24 kB
 public     | opcommand_grp              | 24 kB      | 0 bytes    | 24 kB
 public     | lld_override_opdiscover    | 24 kB      | 8192 bytes | 16 kB
 public     | service_alarms             | 24 kB      | 0 bytes    | 24 kB
 public     | user_scim_group            | 24 kB      | 0 bytes    | 24 kB
 public     | maintenances_hosts         | 24 kB      | 0 bytes    | 24 kB
 public     | rights                     | 24 kB      | 0 bytes    | 24 kB
 public     | httptest_field             | 24 kB      | 0 bytes    | 16 kB
 public     | userdirectory_media        | 24 kB      | 0 bytes    | 24 kB
 public     | report_param               | 24 kB      | 0 bytes    | 16 kB
 public     | sysmaps_element_tag        | 24 kB      | 0 bytes    | 16 kB
 public     | httptest_tag               | 24 kB      | 0 bytes    | 16 kB
 public     | sla_service_tag            | 24 kB      | 0 bytes    | 16 kB
 public     | sysmap_element_trigger     | 24 kB      | 0 bytes    | 24 kB
 public     | icon_mapping               | 24 kB      | 0 bytes    | 24 kB
 public     | opmessage_usr              | 24 kB      | 0 bytes    | 24 kB
 public     | maintenance_tag            | 24 kB      | 0 bytes    | 16 kB
 public     | task_close_problem         | 24 kB      | 8192 bytes | 16 kB
 public     | service_problem_tag        | 24 kB      | 0 bytes    | 16 kB
 public     | dbversion                  | 24 kB      | 8192 bytes | 16 kB
 public     | proxy_autoreg_host         | 24 kB      | 0 bytes    | 16 kB
 public     | sysmap_usrgrp              | 24 kB      | 0 bytes    | 24 kB
 public     | dashboard_user             | 24 kB      | 0 bytes    | 24 kB
 public     | services_links             | 24 kB      | 0 bytes    | 24 kB
 public     | proxy_history              | 24 kB      | 0 bytes    | 16 kB
 public     | userdirectory              | 24 kB      | 0 bytes    | 16 kB
 public     | task_remote_command_result | 16 kB      | 0 bytes    | 8192 bytes
 public     | event_symptom              | 16 kB      | 0 bytes    | 16 kB
 public     | interface_snmp             | 16 kB      | 0 bytes    | 8192 bytes
 public     | corr_condition_tagvalue    | 16 kB      | 0 bytes    | 8192 bytes
 public     | group_discovery            | 16 kB      | 0 bytes    | 16 kB
 public     | sla_schedule               | 16 kB      | 0 bytes    | 16 kB
 public     | corr_condition_tagpair     | 16 kB      | 0 bytes    | 8192 bytes
 public     | scim_group                 | 16 kB      | 0 bytes    | 16 kB
 public     | interface_discovery        | 16 kB      | 0 bytes    | 16 kB
 public     | sla_excluded_downtime      | 16 kB      | 0 bytes    | 16 kB
 public     | corr_condition             | 16 kB      | 0 bytes    | 16 kB
 public     | services                   | 16 kB      | 0 bytes    | 8192 bytes
 public     | userdirectory_saml         | 16 kB      | 0 bytes    | 8192 bytes
 public     | corr_condition_group       | 16 kB      | 0 bytes    | 16 kB
 public     | lld_override_opperiod      | 16 kB      | 0 bytes    | 8192 bytes
 public     | task_remote_command        | 16 kB      | 0 bytes    | 8192 bytes
 public     | dhosts                     | 16 kB      | 0 bytes    | 16 kB
 public     | corr_operation             | 16 kB      | 0 bytes    | 16 kB
 public     | opconditions               | 16 kB      | 0 bytes    | 16 kB
 public     | service_status_rule        | 16 kB      | 0 bytes    | 16 kB
 public     | userdirectory_ldap         | 16 kB      | 0 bytes    | 8192 bytes
 public     | lld_override_opseverity    | 8192 bytes | 0 bytes    | 8192 bytes
 public     | timeperiods                | 8192 bytes | 0 bytes    | 8192 bytes
 public     | lld_override_optrends      | 8192 bytes | 0 bytes    | 8192 bytes
 public     | corr_condition_tag         | 8192 bytes | 0 bytes    | 8192 bytes
 public     | globalvars                 | 8192 bytes | 0 bytes    | 8192 bytes
 public     | opinventory                | 8192 bytes | 0 bytes    | 8192 bytes
 public     | lld_override_ophistory     | 8192 bytes | 0 bytes    | 8192 bytes
 public     | trigger_queue              | 8192 bytes | 0 bytes    | 8192 bytes
 public     | lld_override_opinventory   | 8192 bytes | 0 bytes    | 8192 bytes
(186 rows)


-Bloqueos y conexiones activas en la bd zabbix

CONEXIONES

   pid   |   usename   | datname |   client_addr   | application_name | state  |         backend_start         |          query_start          | wait_event_type | wait_event
---------+-------------+---------+-----------------+------------------+--------+-------------------------------+-------------------------------+-----------------+------------
 2301597 | zabbix      | zabbix  | 180.183.171.147 |                  | idle   | 2026-02-25 09:13:51.109473-04 | 2026-02-25 09:54:30.410306-04 | Client          | ClientRead
 2301595 | zabbix      | zabbix  | 180.183.171.147 |                  | idle   | 2026-02-25 09:13:50.297293-04 | 2026-02-25 09:54:30.281106-04 | Client          | ClientRead
 2301639 | zbx_monitor | zabbix  | 180.183.171.190 |                  | idle   | 2026-02-25 09:14:29.687611-04 | 2026-02-25 09:54:30.158878-04 | Client          | ClientRead
 2301573 | zabbix      | zabbix  | 180.183.171.147 |                  | idle   | 2026-02-25 09:13:41.927319-04 | 2026-02-25 09:54:30.126784-04 | Client          | ClientRead
 2301594 | zabbix      | zabbix  | 180.183.171.147 |                  | idle   | 2026-02-25 09:13:50.155356-04 | 2026-02-25 09:54:29.838449-04 | Client          | ClientRead
 2301583 | zabbix      | zabbix  | 180.183.171.147 |                  | idle   | 2026-02-25 09:13:44.775876-04 | 2026-02-25 09:54:29.764276-04 | Client          | ClientRead
 2301593 | zabbix      | zabbix  | 180.183.171.147 |                  | idle   | 2026-02-25 09:13:50.108322-04 | 2026-02-25 09:54:29.409265-04 | Client          | ClientRead
 2301629 | zabbix      | zabbix  | 180.183.171.147 |                  | idle   | 2026-02-25 09:14:19.292829-04 | 2026-02-25 09:54:28.410198-04 | Client          | ClientRead
 2301574 | zabbix      | zabbix  | 180.183.171.147 |                  | idle   | 2026-02-25 09:13:42.109642-04 | 2026-02-25 09:54:26.407004-04 | Client          | ClientRead
 2301585 | zabbix      | zabbix  | 180.183.171.147 |                  | idle   | 2026-02-25 09:13:46.128429-04 | 2026-02-25 09:54:24.768696-04 | Client          | ClientRead
 2301584 | zabbix      | zabbix  | 180.183.171.147 |                  | idle   | 2026-02-25 09:13:44.812539-04 | 2026-02-25 09:54:19.154128-04 | Client          | ClientRead
 2301628 | zabbix      | zabbix  | 180.183.171.147 |                  | idle   | 2026-02-25 09:14:17.075024-04 | 2026-02-25 09:54:16.463902-04 | Client          | ClientRead
 2301623 | zabbix      | zabbix  | 180.183.171.147 |                  | idle   | 2026-02-25 09:14:14.352816-04 | 2026-02-25 09:54:14.707871-04 | Client          | ClientRead
 2301590 | zabbix      | zabbix  | 180.183.171.147 |                  | idle   | 2026-02-25 09:13:49.60305-04  | 2026-02-25 09:54:12.698062-04 | Client          | ClientRead
 2301634 | zabbix      | zabbix  | 180.183.171.147 |                  | idle   | 2026-02-25 09:14:24.350573-04 | 2026-02-25 09:54:04.248225-04 | Client          | ClientRead
 2301588 | zabbix      | zabbix  | 180.183.171.147 |                  | idle   | 2026-02-25 09:13:48.111234-04 | 2026-02-25 09:53:51.112707-04 | Client          | ClientRead
 2301579 | zabbix      | zabbix  | 180.183.171.147 |                  | idle   | 2026-02-25 09:13:43.948388-04 | 2026-02-25 09:53:46.072238-04 | Client          | ClientRead
 2303360 | zabbix      | zabbix  | 180.183.171.147 |                  | idle   | 2026-02-25 09:43:59.882684-04 | 2026-02-25 09:43:59.894485-04 | Client          | ClientRead
 2302261 | zabbix      | zabbix  | 180.183.171.147 |                  | idle   | 2026-02-25 09:28:59.882229-04 | 2026-02-25 09:28:59.895326-04 | Client          | ClientRead
 2301609 | zabbix      | zabbix  | 180.183.171.147 |                  | idle   | 2026-02-25 09:13:59.467344-04 | 2026-02-25 09:13:59.476683-04 | Client          | ClientRead



-Puerto en que opera
5438
-Espacio total en disco de la BD
16G     /postgres/data/zabbix


-La BD cuenta con TimescaleDB (Que version) o algún particionamiento manual?
No
