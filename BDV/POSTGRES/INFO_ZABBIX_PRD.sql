ZABBIX - PRODUCCIÓN

-Versión de la BD PSQL
PostgreSQL 15.5 


-Tamaño de las tablas de la BD llamada: zabbix
TAMAÑO BD -  17 GB

TAMAÑO TABLAS 

 schemaname |         table_name         | total_size | table_size | index_size
------------+----------------------------+------------+------------+------------
 public     | history                    | 16 GB      | 6835 MB    | 9186 MB
 public     | history_uint               | 654 MB     | 405 MB     | 249 MB
 public     | trends                     | 419 MB     | 231 MB     | 188 MB
 public     | trends_uint                | 131 MB     | 84 MB      | 47 MB
 public     | history_text               | 50 MB      | 38 MB      | 12 MB
 public     | history_log                | 29 MB      | 27 MB      | 2720 kB
 public     | alerts                     | 26 MB      | 17 MB      | 8640 kB
 public     | items                      | 22 MB      | 14 MB      | 8184 kB
 public     | history_str                | 18 MB      | 13 MB      | 4984 kB
 public     | auditlog                   | 17 MB      | 12 MB      | 4480 kB
 public     | events                     | 14 MB      | 8296 kB    | 6128 kB
 public     | valuemap_mapping           | 4544 kB    | 2192 kB    | 2320 kB
 public     | item_preproc               | 3072 kB    | 1792 kB    | 1192 kB
 public     | item_discovery             | 3072 kB    | 1544 kB    | 1488 kB
 public     | item_tag                   | 3016 kB    | 1720 kB    | 1256 kB
 public     | triggers                   | 2944 kB    | 2424 kB    | 480 kB
 public     | changelog                  | 2880 kB    | 8192 bytes | 2840 kB
 public     | event_tag                  | 2784 kB    | 1752 kB    | 992 kB
 public     | event_recovery             | 2736 kB    | 1192 kB    | 1512 kB
 public     | functions                  | 1728 kB    | 696 kB     | 1000 kB
 public     | widget_field               | 1472 kB    | 512 kB     | 920 kB
 public     | hostmacro                  | 1256 kB    | 688 kB     | 528 kB
 public     | images                     | 1200 kB    | 80 kB      | 32 kB
 public     | trigger_tag                | 1016 kB    | 536 kB     | 440 kB
 public     | sessions                   | 984 kB     | 64 kB      | 888 kB
 public     | housekeeper                | 912 kB     | 8192 bytes | 888 kB
 public     | graphs_items               | 816 kB     | 392 kB     | 392 kB
 public     | hosts                      | 696 kB     | 408 kB     | 200 kB
 public     | graphs                     | 648 kB     | 336 kB     | 280 kB
 public     | problem                    | 520 kB     | 40 kB      | 440 kB
 public     | profiles                   | 512 kB     | 168 kB     | 304 kB
 public     | item_condition             | 424 kB     | 256 kB     | 136 kB
 public     | item_rtdata                | 408 kB     | 192 kB     | 176 kB
 public     | trigger_depends            | 352 kB     | 104 kB     | 216 kB
 public     | acknowledges               | 288 kB     | 112 kB     | 136 kB
 public     | ha_node                    | 288 kB     | 104 kB     | 144 kB
 public     | valuemap                   | 288 kB     | 120 kB     | 136 kB
 public     | widget                     | 256 kB     | 128 kB     | 88 kB
 public     | escalations                | 256 kB     | 8192 bytes | 216 kB
 public     | media_type                 | 224 kB     | 24 kB      | 32 kB
 public     | problem_tag                | 200 kB     | 8192 bytes | 152 kB
 public     | lld_macro_path             | 184 kB     | 56 kB      | 88 kB
 public     | host_tag                   | 184 kB     | 64 kB      | 80 kB
 public     | media_type_param           | 144 kB     | 56 kB      | 48 kB
 public     | sysmaps_elements           | 144 kB     | 8192 bytes | 96 kB
 public     | media_type_message         | 136 kB     | 64 kB      | 32 kB
 public     | item_parameter             | 128 kB     | 40 kB      | 48 kB
 public     | sysmaps                    | 128 kB     | 8192 bytes | 80 kB
 public     | task                       | 128 kB     | 8192 bytes | 88 kB
 public     | config                     | 128 kB     | 8192 bytes | 80 kB
 public     | scripts                    | 120 kB     | 16 kB      | 64 kB
 public     | hosts_groups               | 120 kB     | 24 kB      | 64 kB
 public     | dashboard                  | 120 kB     | 40 kB      | 48 kB
 public     | interface                  | 112 kB     | 8192 bytes | 64 kB
 public     | role_rule                  | 112 kB     | 8192 bytes | 64 kB
 public     | users                      | 112 kB     | 8192 bytes | 64 kB
 public     | group_prototype            | 104 kB     | 8192 bytes | 64 kB
 public     | trigger_discovery          | 104 kB     | 40 kB      | 32 kB
 public     | event_suppress             | 96 kB      | 0 bytes    | 80 kB
 public     | drules                     | 96 kB      | 8192 bytes | 48 kB
 public     | actions                    | 96 kB      | 8192 bytes | 48 kB
 public     | dashboard_page             | 96 kB      | 32 kB      | 32 kB
 public     | host_discovery             | 88 kB      | 8192 bytes | 48 kB
 public     | opgroup                    | 88 kB      | 8192 bytes | 48 kB
 public     | dashboard_usrgrp           | 88 kB      | 8192 bytes | 48 kB
 public     | opcommand_hst              | 88 kB      | 8192 bytes | 48 kB
 public     | dashboard_user             | 88 kB      | 8192 bytes | 48 kB
 public     | optemplate                 | 88 kB      | 8192 bytes | 48 kB
 public     | opmessage_grp              | 88 kB      | 8192 bytes | 48 kB
 public     | usrgrp                     | 88 kB      | 8192 bytes | 48 kB
 public     | users_groups               | 88 kB      | 8192 bytes | 48 kB
 public     | rights                     | 88 kB      | 8192 bytes | 48 kB
 public     | lld_override_optemplate    | 88 kB      | 8192 bytes | 48 kB
 public     | hosts_templates            | 88 kB      | 8192 bytes | 48 kB
 public     | lld_override               | 88 kB      | 16 kB      | 32 kB
 public     | conditions                 | 80 kB      | 8192 bytes | 32 kB
 public     | lld_override_optag         | 80 kB      | 8192 bytes | 32 kB
 public     | regexps                    | 80 kB      | 8192 bytes | 32 kB
 public     | lld_override_condition     | 80 kB      | 16 kB      | 32 kB
 public     | lld_override_operation     | 80 kB      | 16 kB      | 32 kB
 public     | dchecks                    | 80 kB      | 8192 bytes | 32 kB
 public     | httptest                   | 80 kB      | 8192 bytes | 64 kB
 public     | opmessage                  | 80 kB      | 8192 bytes | 32 kB
 public     | config_autoreg_tls         | 80 kB      | 8192 bytes | 32 kB
 public     | globalmacro                | 80 kB      | 8192 bytes | 32 kB
 public     | sysmap_shape               | 80 kB      | 8192 bytes | 32 kB
 public     | graph_theme                | 72 kB      | 8192 bytes | 32 kB
 public     | graph_discovery            | 72 kB      | 8192 bytes | 32 kB
 public     | role                       | 72 kB      | 8192 bytes | 32 kB
 public     | expressions                | 72 kB      | 8192 bytes | 32 kB
 public     | operations                 | 72 kB      | 8192 bytes | 32 kB
 public     | opcommand                  | 72 kB      | 8192 bytes | 32 kB
 public     | hstgrp                     | 72 kB      | 8192 bytes | 32 kB
 public     | module                     | 64 kB      | 8192 bytes | 16 kB
 public     | host_inventory             | 64 kB      | 8192 bytes | 16 kB
 public     | opcommand_grp              | 64 kB      | 0 bytes    | 48 kB
 public     | dbversion                  | 56 kB      | 8192 bytes | 16 kB
 public     | httptestitem               | 56 kB      | 8192 bytes | 48 kB
 public     | lld_override_opstatus      | 56 kB      | 8192 bytes | 16 kB
 public     | host_rtdata                | 56 kB      | 8192 bytes | 16 kB
 public     | httpstepitem               | 56 kB      | 8192 bytes | 48 kB
 public     | lld_override_opdiscover    | 56 kB      | 8192 bytes | 16 kB
 public     | ids                        | 56 kB      | 8192 bytes | 16 kB
 public     | token                      | 48 kB      | 0 bytes    | 40 kB
 public     | httpstep_field             | 48 kB      | 8192 bytes | 32 kB
 public     | httpstep                   | 48 kB      | 8192 bytes | 32 kB
 public     | task_data                  | 40 kB      | 0 bytes    | 16 kB
 public     | sysmaps_links              | 40 kB      | 0 bytes    | 32 kB
 public     | task_close_problem         | 40 kB      | 8192 bytes | 16 kB
 public     | task_check_now             | 40 kB      | 8192 bytes | 16 kB
 public     | report                     | 40 kB      | 0 bytes    | 32 kB
 public     | task_acknowledge           | 40 kB      | 8192 bytes | 16 kB
 public     | correlation                | 32 kB      | 0 bytes    | 24 kB
 public     | maintenances               | 32 kB      | 0 bytes    | 24 kB
 public     | autoreg_host               | 32 kB      | 0 bytes    | 24 kB
 public     | report_usrgrp              | 32 kB      | 0 bytes    | 32 kB
 public     | report_user                | 32 kB      | 0 bytes    | 32 kB
 public     | media                      | 32 kB      | 0 bytes    | 24 kB
 public     | proxy_dhistory             | 32 kB      | 0 bytes    | 24 kB
 public     | tag_filter                 | 32 kB      | 0 bytes    | 24 kB
 public     | userdirectory_usrgrp       | 32 kB      | 0 bytes    | 32 kB
 public     | dservices                  | 32 kB      | 0 bytes    | 24 kB
 public     | maintenances_groups        | 24 kB      | 0 bytes    | 24 kB
 public     | service_problem_tag        | 24 kB      | 0 bytes    | 16 kB
 public     | service_alarms             | 24 kB      | 0 bytes    | 24 kB
 public     | task_result                | 24 kB      | 0 bytes    | 16 kB
 public     | sla_service_tag            | 24 kB      | 0 bytes    | 16 kB
 public     | sysmap_url                 | 24 kB      | 0 bytes    | 16 kB
 public     | proxy_autoreg_host         | 24 kB      | 0 bytes    | 16 kB
 public     | userdirectory_media        | 24 kB      | 0 bytes    | 24 kB
 public     | icon_mapping               | 24 kB      | 0 bytes    | 24 kB
 public     | maintenance_tag            | 24 kB      | 0 bytes    | 16 kB
 public     | connector                  | 24 kB      | 0 bytes    | 16 kB
 public     | script_param               | 24 kB      | 0 bytes    | 16 kB
 public     | user_scim_group            | 24 kB      | 0 bytes    | 24 kB
 public     | maintenances_hosts         | 24 kB      | 0 bytes    | 24 kB
 public     | sysmap_user                | 24 kB      | 0 bytes    | 24 kB
 public     | sysmap_element_trigger     | 24 kB      | 0 bytes    | 24 kB
 public     | httptest_tag               | 24 kB      | 0 bytes    | 16 kB
 public     | sysmaps_link_triggers      | 24 kB      | 0 bytes    | 24 kB
 public     | userdirectory_idpgroup     | 24 kB      | 0 bytes    | 24 kB
 public     | httptest_field             | 24 kB      | 0 bytes    | 16 kB
 public     | sla                        | 24 kB      | 0 bytes    | 16 kB
 public     | sysmap_usrgrp              | 24 kB      | 0 bytes    | 24 kB
 public     | icon_map                   | 24 kB      | 0 bytes    | 24 kB
 public     | service_tag                | 24 kB      | 0 bytes    | 16 kB
 public     | opmessage_usr              | 24 kB      | 0 bytes    | 24 kB
 public     | sysmaps_element_tag        | 24 kB      | 0 bytes    | 16 kB
 public     | maintenances_windows       | 24 kB      | 0 bytes    | 24 kB
 public     | connector_tag              | 24 kB      | 0 bytes    | 16 kB
 public     | services_links             | 24 kB      | 0 bytes    | 24 kB
 public     | report_param               | 24 kB      | 0 bytes    | 16 kB
 public     | service_problem            | 24 kB      | 0 bytes    | 24 kB
 public     | sysmap_element_url         | 24 kB      | 0 bytes    | 16 kB
 public     | proxy_history              | 24 kB      | 0 bytes    | 16 kB
 public     | userdirectory              | 24 kB      | 0 bytes    | 16 kB
 public     | corr_condition_tagpair     | 16 kB      | 0 bytes    | 8192 bytes
 public     | sla_excluded_downtime      | 16 kB      | 0 bytes    | 16 kB
 public     | corr_condition             | 16 kB      | 0 bytes    | 16 kB
 public     | group_discovery            | 16 kB      | 0 bytes    | 16 kB
 public     | corr_condition_tagvalue    | 16 kB      | 0 bytes    | 8192 bytes
 public     | service_status_rule        | 16 kB      | 0 bytes    | 16 kB
 public     | userdirectory_saml         | 16 kB      | 0 bytes    | 8192 bytes
 public     | task_remote_command_result | 16 kB      | 0 bytes    | 8192 bytes
 public     | lld_override_opperiod      | 16 kB      | 0 bytes    | 8192 bytes
 public     | task_remote_command        | 16 kB      | 0 bytes    | 8192 bytes
 public     | interface_snmp             | 16 kB      | 0 bytes    | 8192 bytes
 public     | corr_condition_group       | 16 kB      | 0 bytes    | 16 kB
 public     | dhosts                     | 16 kB      | 0 bytes    | 16 kB
 public     | event_symptom              | 16 kB      | 0 bytes    | 16 kB
 public     | userdirectory_ldap         | 16 kB      | 0 bytes    | 8192 bytes
 public     | services                   | 16 kB      | 0 bytes    | 8192 bytes
 public     | scim_group                 | 16 kB      | 0 bytes    | 16 kB
 public     | opconditions               | 16 kB      | 0 bytes    | 16 kB
 public     | interface_discovery        | 16 kB      | 0 bytes    | 16 kB
 public     | sla_schedule               | 16 kB      | 0 bytes    | 16 kB
 public     | corr_operation             | 16 kB      | 0 bytes    | 16 kB
 public     | lld_override_optrends      | 8192 bytes | 0 bytes    | 8192 bytes
 public     | corr_condition_tag         | 8192 bytes | 0 bytes    | 8192 bytes
 public     | timeperiods                | 8192 bytes | 0 bytes    | 8192 bytes
 public     | globalvars                 | 8192 bytes | 0 bytes    | 8192 bytes
 public     | trigger_queue              | 8192 bytes | 0 bytes    | 8192 bytes
 public     | opinventory                | 8192 bytes | 0 bytes    | 8192 bytes
 public     | lld_override_opseverity    | 8192 bytes | 0 bytes    | 8192 bytes
 public     | lld_override_opinventory   | 8192 bytes | 0 bytes    | 8192 bytes
 public     | lld_override_ophistory     | 8192 bytes | 0 bytes    | 8192 bytes





-Bloqueos y conexiones activas en la bd zabbix

CONEXIONES

   pid   | usename  | datname | client_addr  | application_name | state  |         backend_start         |          query_start          | wait_event_type | wait_event
---------+----------+---------+--------------+------------------+--------+-------------------------------+-------------------------------+-----------------+------------
  584338 | zabbix   | zabbix  | 172.27.67.74 |                  | idle   | 2026-02-24 15:19:11.987982-04 | 2026-02-24 15:19:12.000173-04 | Client          | ClientRead
  584340 | zabbix   | zabbix  | 172.27.67.74 |                  | active | 2026-02-24 15:19:11.989178-04 | 2026-02-24 15:19:11.999867-04 |                 |
  584339 | zabbix   | zabbix  | 172.27.67.74 |                  | active | 2026-02-24 15:19:11.988075-04 | 2026-02-24 15:19:11.998588-04 |                 |
 1136684 | zabbix   | zabbix  | 172.27.67.74 |                  | idle   | 2025-10-22 14:04:05.793382-04 | 2026-02-24 15:19:11.602742-04 | Client          | ClientRead
 1136686 | zabbix   | zabbix  | 172.27.67.74 |                  | idle   | 2025-10-22 14:04:05.80677-04  | 2026-02-24 15:19:11.241332-04 | Client          | ClientRead
 1136689 | zabbix   | zabbix  | 172.27.67.74 |                  | idle   | 2025-10-22 14:04:05.809426-04 | 2026-02-24 15:19:11.045072-04 | Client          | ClientRead
 1136648 | zabbix   | zabbix  | 172.27.67.74 |                  | idle   | 2025-10-22 14:04:05.574854-04 | 2026-02-24 15:19:10.904357-04 | Client          | ClientRead
 1136681 | zabbix   | zabbix  | 172.27.67.74 |                  | idle   | 2025-10-22 14:04:05.791936-04 | 2026-02-24 15:19:10.240751-04 | Client          | ClientRead
 1136651 | zabbix   | zabbix  | 172.27.67.74 |                  | idle   | 2025-10-22 14:04:05.590028-04 | 2026-02-24 15:19:09.936969-04 | Client          | ClientRead
 1136678 | zabbix   | zabbix  | 172.27.67.74 |                  | idle   | 2025-10-22 14:04:05.780196-04 | 2026-02-24 15:19:09.59778-04  | Client          | ClientRead
 1136673 | zabbix   | zabbix  | 172.27.67.74 |                  | idle   | 2025-10-22 14:04:05.773915-04 | 2026-02-24 15:19:09.166458-04 | Client          | ClientRead
 1136680 | zabbix   | zabbix  | 172.27.67.74 |                  | idle   | 2025-10-22 14:04:05.785676-04 | 2026-02-24 15:19:08.606209-04 | Client          | ClientRead
 1136688 | zabbix   | zabbix  | 172.27.67.74 |                  | idle   | 2025-10-22 14:04:05.807312-04 | 2026-02-24 15:19:08.093572-04 | Client          | ClientRead
 1136652 | zabbix   | zabbix  | 172.27.67.74 |                  | idle   | 2025-10-22 14:04:05.59032-04  | 2026-02-24 15:19:07.874339-04 | Client          | ClientRead
 1136672 | zabbix   | zabbix  | 172.27.67.74 |                  | idle   | 2025-10-22 14:04:05.773787-04 | 2026-02-24 15:18:58.360812-04 | Client          | ClientRead
 1136676 | zabbix   | zabbix  | 172.27.67.74 |                  | idle   | 2025-10-22 14:04:05.776179-04 | 2026-02-24 15:18:53.22661-04  | Client          | ClientRead
 1136696 | zabbix   | zabbix  | 172.27.67.74 |                  | idle   | 2025-10-22 14:04:05.813841-04 | 2026-02-24 15:18:53.06963-04  | Client          | ClientRead
 1136687 | zabbix   | zabbix  | 172.27.67.74 |                  | idle   | 2025-10-22 14:04:05.806923-04 | 2026-02-24 15:18:48.768922-04 | Client          | ClientRead
 1136694 | zabbix   | zabbix  | 172.27.67.74 |                  | idle   | 2025-10-22 14:04:05.811088-04 | 2026-02-24 15:13:57.176637-04 | Client          | ClientRead
 1136695 | zabbix   | zabbix  | 172.27.67.74 |                  | idle   | 2025-10-22 14:04:05.811951-04 | 2026-02-24 15:13:57.175168-04 | Client          | ClientRead
 1136701 | zabbix   | zabbix  | 172.27.67.74 |                  | idle   | 2025-10-22 14:04:05.824305-04 | 2026-02-24 15:13:19.371512-04 | Client          | ClientRead
 1136697 | zabbix   | zabbix  | 172.27.67.74 |                  | idle   | 2025-10-22 14:04:05.814697-04 | 2026-02-24 15:12:18.92257-04  | Client          | ClientRead
 1136700 | zabbix   | zabbix  | 172.27.67.74 |                  | idle   | 2025-10-22 14:04:05.816688-04 | 2026-02-12 16:40:59.198862-04 | Client          | ClientRead
 1136693 | zabbix   | zabbix  | 172.27.67.74 |                  | idle   | 2025-10-22 14:04:05.810252-04 | 2026-02-11 15:19:58.472585-04 | Client          | ClientRead
 1136677 | zabbix   | zabbix  | 172.27.67.74 |                  | idle   | 2025-10-22 14:04:05.777057-04 | 2026-02-11 15:19:49.814252-04 | Client          | ClientRead
 1136692 | zabbix   | zabbix  | 172.27.67.74 |                  | idle   | 2025-10-22 14:04:05.809958-04 | 2026-01-06 13:10:25.400443-04 | Client          | ClientRead
 1136699 | zabbix   | zabbix  | 172.27.67.74 |                  | idle   | 2025-10-22 14:04:05.815959-04 | 2026-01-06 13:10:22.397791-04 | Client          | ClientRead
 1136702 | zabbix   | zabbix  | 172.27.67.74 |                  | idle   | 2025-10-22 14:04:05.823725-04 | 2026-01-06 13:10:21.399868-04 | Client          | ClientRead
 1136691 | zabbix   | zabbix  | 172.27.67.74 |                  | idle   | 2025-10-22 14:04:05.809704-04 | 2026-01-06 13:09:21.346674-04 | Client          | ClientRead
 1136683 | zabbix   | zabbix  | 172.27.67.74 |                  | idle   | 2025-10-22 14:04:05.793278-04 | 2025-10-22 14:04:05.832635-04 | Client          | ClientRead
 1136679 | zabbix   | zabbix  | 172.27.67.74 |                  | idle   | 2025-10-22 14:04:05.78368-04  | 2025-10-22 14:04:05.804712-04 | Client          | ClientRead



-Puerto en que opera
5489
-Espacio total en disco de la BD
18G     /postgres/data


-La BD cuenta con TimescaleDB (Que version) o algún particionamiento manual?
No