ZABBIX - DESARROLLO

-Versión de la BD PSQL

PostgreSQL 15.5 


-Tamaño de las tablas de la BD llamada: zabbix
 TAMAÑO BD -  1792 MB

TAMAÑO TABLAS 

 schemaname |         table_name         | total_size | table_size | index_size
------------+----------------------------+------------+------------+------------
 public     | history_uint               | 576 MB     | 351 MB     | 225 MB
 public     | history                    | 403 MB     | 249 MB     | 154 MB
 public     | trends                     | 370 MB     | 237 MB     | 133 MB
 public     | trends_uint                | 343 MB     | 225 MB     | 118 MB
 public     | items                      | 20 MB      | 14 MB      | 5792 kB
 public     | history_text               | 18 MB      | 14 MB      | 4640 kB
 public     | events                     | 4744 kB    | 2352 kB    | 2352 kB
 public     | valuemap_mapping           | 4544 kB    | 2192 kB    | 2320 kB
 public     | auditlog                   | 4384 kB    | 3632 kB    | 712 kB
 public     | event_tag                  | 3720 kB    | 2312 kB    | 1368 kB
 public     | item_tag                   | 3264 kB    | 1896 kB    | 1328 kB
 public     | triggers                   | 3264 kB    | 2656 kB    | 568 kB
 public     | item_preproc               | 3200 kB    | 1912 kB    | 1232 kB
 public     | changelog                  | 2864 kB    | 8192 bytes | 2840 kB
 public     | functions                  | 1912 kB    | 792 kB     | 1088 kB
 public     | item_discovery             | 1280 kB    | 648 kB     | 592 kB
 public     | hostmacro                  | 1256 kB    | 688 kB     | 528 kB
 public     | images                     | 1192 kB    | 80 kB      | 32 kB
 public     | event_recovery             | 1120 kB    | 456 kB     | 632 kB
 public     | trigger_tag                | 1104 kB    | 592 kB     | 472 kB
 public     | graphs_items               | 912 kB     | 448 kB     | 432 kB
 public     | widget_field               | 848 kB     | 224 kB     | 584 kB
 public     | graphs                     | 688 kB     | 368 kB     | 288 kB
 public     | history_log                | 688 kB     | 0 bytes    | 664 kB
 public     | hosts                      | 664 kB     | 408 kB     | 200 kB
 public     | item_condition             | 424 kB     | 256 kB     | 136 kB
 public     | profiles                   | 360 kB     | 112 kB     | 208 kB
 public     | trigger_depends            | 360 kB     | 104 kB     | 224 kB
 public     | history_str                | 328 kB     | 176 kB     | 120 kB
 public     | valuemap                   | 288 kB     | 120 kB     | 136 kB
 public     | widget                     | 232 kB     | 112 kB     | 80 kB
 public     | media_type                 | 208 kB     | 24 kB      | 32 kB
 public     | housekeeper                | 200 kB     | 32 kB      | 136 kB
 public     | problem_tag                | 200 kB     | 8192 bytes | 152 kB
 public     | host_tag                   | 176 kB     | 64 kB      | 80 kB
 public     | lld_macro_path             | 176 kB     | 56 kB      | 88 kB
 public     | item_rtdata                | 160 kB     | 64 kB      | 56 kB
 public     | problem                    | 144 kB     | 24 kB      | 80 kB
 public     | media_type_param           | 136 kB     | 56 kB      | 48 kB
 public     | media_type_message         | 128 kB     | 64 kB      | 32 kB
 public     | item_parameter             | 120 kB     | 40 kB      | 48 kB
 public     | dashboard                  | 112 kB     | 40 kB      | 48 kB
 public     | interface                  | 112 kB     | 8192 bytes | 64 kB
 public     | hosts_groups               | 112 kB     | 24 kB      | 64 kB
 public     | sysmaps_elements           | 112 kB     | 8192 bytes | 96 kB
 public     | config                     | 96 kB      | 8192 bytes | 80 kB
 public     | sysmap_element_trigger     | 96 kB      | 16 kB      | 48 kB
 public     | ha_node                    | 96 kB      | 8192 bytes | 48 kB
 public     | sysmaps                    | 96 kB      | 8192 bytes | 80 kB
 public     | hosts_templates            | 88 kB      | 8192 bytes | 48 kB
 public     | trigger_discovery          | 88 kB      | 24 kB      | 32 kB
 public     | event_suppress             | 88 kB      | 8192 bytes | 80 kB
 public     | acknowledges               | 80 kB      | 8192 bytes | 64 kB
 public     | alerts                     | 80 kB      | 0 bytes    | 72 kB
 public     | role_rule                  | 80 kB      | 8192 bytes | 64 kB
 public     | scripts                    | 80 kB      | 8192 bytes | 64 kB
 public     | users                      | 80 kB      | 8192 bytes | 64 kB
 public     | dashboard_page             | 80 kB      | 24 kB      | 32 kB
 public     | sysmaps_links              | 80 kB      | 8192 bytes | 64 kB
 public     | lld_override               | 80 kB      | 16 kB      | 32 kB
 public     | lld_override_operation     | 72 kB      | 16 kB      | 32 kB
 public     | sessions                   | 72 kB      | 8192 bytes | 32 kB
 public     | graph_discovery            | 72 kB      | 8192 bytes | 32 kB
 public     | lld_override_condition     | 72 kB      | 16 kB      | 32 kB
 public     | group_prototype            | 72 kB      | 8192 bytes | 64 kB
 public     | task                       | 64 kB      | 0 bytes    | 48 kB
 public     | actions                    | 64 kB      | 8192 bytes | 48 kB
 public     | drules                     | 64 kB      | 8192 bytes | 48 kB
 public     | icon_map                   | 56 kB      | 8192 bytes | 48 kB
 public     | lld_override_optemplate    | 56 kB      | 8192 bytes | 48 kB
 public     | dashboard_usrgrp           | 56 kB      | 8192 bytes | 48 kB
 public     | ids                        | 56 kB      | 8192 bytes | 16 kB
 public     | usrgrp                     | 56 kB      | 8192 bytes | 48 kB
 public     | host_rtdata                | 56 kB      | 8192 bytes | 16 kB
 public     | opgroup                    | 56 kB      | 8192 bytes | 48 kB
 public     | optemplate                 | 56 kB      | 8192 bytes | 48 kB
 public     | opmessage_grp              | 56 kB      | 8192 bytes | 48 kB
 public     | users_groups               | 56 kB      | 8192 bytes | 48 kB
 public     | host_discovery             | 56 kB      | 8192 bytes | 48 kB
 public     | icon_mapping               | 56 kB      | 8192 bytes | 48 kB
 public     | sysmaps_link_triggers      | 56 kB      | 8192 bytes | 48 kB
 public     | conditions                 | 48 kB      | 8192 bytes | 32 kB
 public     | lld_override_optag         | 48 kB      | 8192 bytes | 32 kB
 public     | regexps                    | 48 kB      | 8192 bytes | 32 kB
 public     | dchecks                    | 48 kB      | 8192 bytes | 32 kB
 public     | token                      | 48 kB      | 0 bytes    | 40 kB
 public     | userdirectory              | 48 kB      | 8192 bytes | 32 kB
 public     | opmessage                  | 48 kB      | 8192 bytes | 32 kB
 public     | config_autoreg_tls         | 48 kB      | 8192 bytes | 32 kB
 public     | globalmacro                | 48 kB      | 8192 bytes | 32 kB
 public     | sysmap_shape               | 48 kB      | 8192 bytes | 32 kB
 public     | graph_theme                | 40 kB      | 8192 bytes | 32 kB
 public     | httptest                   | 40 kB      | 0 bytes    | 32 kB
 public     | hstgrp                     | 40 kB      | 8192 bytes | 32 kB
 public     | report                     | 40 kB      | 0 bytes    | 32 kB
 public     | role                       | 40 kB      | 8192 bytes | 32 kB
 public     | operations                 | 40 kB      | 8192 bytes | 32 kB
 public     | expressions                | 40 kB      | 8192 bytes | 32 kB
 public     | userdirectory_ldap         | 32 kB      | 8192 bytes | 16 kB
 public     | media                      | 32 kB      | 0 bytes    | 24 kB
 public     | userdirectory_usrgrp       | 32 kB      | 0 bytes    | 32 kB
 public     | escalations                | 32 kB      | 0 bytes    | 32 kB
 public     | report_user                | 32 kB      | 0 bytes    | 32 kB
 public     | task_data                  | 32 kB      | 8192 bytes | 16 kB
 public     | module                     | 32 kB      | 8192 bytes | 16 kB
 public     | dservices                  | 32 kB      | 0 bytes    | 24 kB
 public     | host_inventory             | 32 kB      | 8192 bytes | 16 kB
 public     | proxy_dhistory             | 32 kB      | 0 bytes    | 24 kB
 public     | report_usrgrp              | 32 kB      | 0 bytes    | 32 kB
 public     | tag_filter                 | 32 kB      | 0 bytes    | 24 kB
 public     | maintenances               | 32 kB      | 0 bytes    | 24 kB
 public     | autoreg_host               | 32 kB      | 0 bytes    | 24 kB
 public     | correlation                | 32 kB      | 0 bytes    | 24 kB
 public     | proxy_autoreg_host         | 24 kB      | 0 bytes    | 16 kB
 public     | services_links             | 24 kB      | 0 bytes    | 24 kB
 public     | proxy_history              | 24 kB      | 0 bytes    | 16 kB
 public     | lld_override_opstatus      | 24 kB      | 8192 bytes | 16 kB
 public     | script_param               | 24 kB      | 0 bytes    | 16 kB
 public     | sysmap_user                | 24 kB      | 0 bytes    | 24 kB
 public     | task_result                | 24 kB      | 0 bytes    | 16 kB
 public     | maintenances_groups        | 24 kB      | 0 bytes    | 24 kB
 public     | sysmap_element_url         | 24 kB      | 0 bytes    | 16 kB
 public     | connector                  | 24 kB      | 0 bytes    | 16 kB
 public     | sla                        | 24 kB      | 0 bytes    | 16 kB
 public     | maintenances_windows       | 24 kB      | 0 bytes    | 24 kB
 public     | connector_tag              | 24 kB      | 0 bytes    | 16 kB
 public     | httpstep_field             | 24 kB      | 0 bytes    | 16 kB
 public     | httpstepitem               | 24 kB      | 0 bytes    | 24 kB
 public     | service_tag                | 24 kB      | 0 bytes    | 16 kB
 public     | service_problem            | 24 kB      | 0 bytes    | 24 kB
 public     | httpstep                   | 24 kB      | 0 bytes    | 16 kB
 public     | service_alarms             | 24 kB      | 0 bytes    | 24 kB
 public     | opcommand_grp              | 24 kB      | 0 bytes    | 24 kB
 public     | sla_service_tag            | 24 kB      | 0 bytes    | 16 kB
 public     | user_scim_group            | 24 kB      | 0 bytes    | 24 kB
 public     | maintenances_hosts         | 24 kB      | 0 bytes    | 24 kB
 public     | userdirectory_media        | 24 kB      | 0 bytes    | 24 kB
 public     | rights                     | 24 kB      | 0 bytes    | 24 kB
 public     | httptest_field             | 24 kB      | 0 bytes    | 16 kB
 public     | report_param               | 24 kB      | 0 bytes    | 16 kB
 public     | task_acknowledge           | 24 kB      | 8192 bytes | 16 kB
 public     | sysmaps_element_tag        | 24 kB      | 0 bytes    | 16 kB
 public     | httptest_tag               | 24 kB      | 0 bytes    | 16 kB
 public     | httptestitem               | 24 kB      | 0 bytes    | 24 kB
 public     | opmessage_usr              | 24 kB      | 0 bytes    | 24 kB
 public     | maintenance_tag            | 24 kB      | 0 bytes    | 16 kB
 public     | opcommand_hst              | 24 kB      | 0 bytes    | 24 kB
 public     | task_close_problem         | 24 kB      | 8192 bytes | 16 kB
 public     | service_problem_tag        | 24 kB      | 0 bytes    | 16 kB
 public     | dbversion                  | 24 kB      | 8192 bytes | 16 kB
 public     | lld_override_opdiscover    | 24 kB      | 8192 bytes | 16 kB
 public     | sysmap_usrgrp              | 24 kB      | 0 bytes    | 24 kB
 public     | userdirectory_idpgroup     | 24 kB      | 0 bytes    | 24 kB
 public     | sysmap_url                 | 24 kB      | 0 bytes    | 16 kB
 public     | dashboard_user             | 24 kB      | 0 bytes    | 24 kB
 public     | group_discovery            | 16 kB      | 0 bytes    | 16 kB
 public     | corr_condition_tagpair     | 16 kB      | 0 bytes    | 8192 bytes
 public     | corr_operation             | 16 kB      | 0 bytes    | 16 kB
 public     | services                   | 16 kB      | 0 bytes    | 8192 bytes
 public     | service_status_rule        | 16 kB      | 0 bytes    | 16 kB
 public     | corr_condition_group       | 16 kB      | 0 bytes    | 16 kB
 public     | sla_schedule               | 16 kB      | 0 bytes    | 16 kB
 public     | userdirectory_saml         | 16 kB      | 0 bytes    | 8192 bytes
 public     | interface_discovery        | 16 kB      | 0 bytes    | 16 kB
 public     | corr_condition_tagvalue    | 16 kB      | 0 bytes    | 8192 bytes
 public     | opcommand                  | 16 kB      | 0 bytes    | 16 kB
 public     | task_remote_command_result | 16 kB      | 0 bytes    | 8192 bytes
 public     | event_symptom              | 16 kB      | 0 bytes    | 16 kB
 public     | scim_group                 | 16 kB      | 0 bytes    | 16 kB
 public     | corr_condition             | 16 kB      | 0 bytes    | 16 kB
 public     | lld_override_opperiod      | 16 kB      | 0 bytes    | 8192 bytes
 public     | task_remote_command        | 16 kB      | 0 bytes    | 8192 bytes
 public     | opconditions               | 16 kB      | 0 bytes    | 16 kB
 public     | interface_snmp             | 16 kB      | 0 bytes    | 8192 bytes
 public     | sla_excluded_downtime      | 16 kB      | 0 bytes    | 16 kB
 public     | dhosts                     | 16 kB      | 0 bytes    | 16 kB
 public     | globalvars                 | 8192 bytes | 0 bytes    | 8192 bytes
 public     | timeperiods                | 8192 bytes | 0 bytes    | 8192 bytes
 public     | lld_override_opseverity    | 8192 bytes | 0 bytes    | 8192 bytes
 public     | task_check_now             | 8192 bytes | 0 bytes    | 8192 bytes
 public     | opinventory                | 8192 bytes | 0 bytes    | 8192 bytes
 public     | lld_override_opinventory   | 8192 bytes | 0 bytes    | 8192 bytes
 public     | corr_condition_tag         | 8192 bytes | 0 bytes    | 8192 bytes
 public     | lld_override_ophistory     | 8192 bytes | 0 bytes    | 8192 bytes
 public     | lld_override_optrends      | 8192 bytes | 0 bytes    | 8192 bytes
 public     | trigger_queue              | 8192 bytes | 0 bytes    | 8192 bytes


-Bloqueos y conexiones activas en la bd zabbix

CONEXIONES

   pid   |   usename   | datname |   client_addr   | application_name | state  |         backend_start         |          query_start          | wait_event_type | wait_event
---------+-------------+---------+-----------------+------------------+--------+-------------------------------+-------------------------------+-----------------+------------
 3840131 | zabbix      | zabbix  | 180.183.174.169 |                  | idle   | 2025-02-11 12:06:06.189459-04 | 2026-02-24 15:23:51.659073-04 | Client          | ClientRead
 3840149 | zabbix      | zabbix  | 180.183.174.169 |                  | idle   | 2025-02-11 12:06:06.205988-04 | 2026-02-24 15:23:51.271203-04 | Client          | ClientRead
 3840128 | zabbix      | zabbix  | 180.183.174.169 |                  | idle   | 2025-02-11 12:06:06.188466-04 | 2026-02-24 15:23:50.658503-04 | Client          | ClientRead
 3840122 | zabbix      | zabbix  | 180.183.174.169 |                  | idle   | 2025-02-11 12:06:06.028509-04 | 2026-02-24 15:23:50.374003-04 | Client          | ClientRead
 3840133 | zabbix      | zabbix  | 180.183.174.169 |                  | idle   | 2025-02-11 12:06:06.190013-04 | 2026-02-24 15:23:49.696771-04 | Client          | ClientRead
 3840127 | zabbix      | zabbix  | 180.183.174.169 |                  | idle   | 2025-02-11 12:06:06.188239-04 | 2026-02-24 15:23:49.65849-04  | Client          | ClientRead
 3840134 | zabbix      | zabbix  | 180.183.174.169 |                  | idle   | 2025-02-11 12:06:06.190967-04 | 2026-02-24 15:23:49.653545-04 | Client          | ClientRead
 3840130 | zabbix      | zabbix  | 180.183.174.169 |                  | idle   | 2025-02-11 12:06:06.188997-04 | 2026-02-24 15:23:48.659071-04 | Client          | ClientRead
 3840123 | zabbix      | zabbix  | 180.183.174.169 |                  | idle   | 2025-02-11 12:06:06.056716-04 | 2026-02-24 15:23:45.929981-04 | Client          | ClientRead
 3840136 | zabbix      | zabbix  | 180.183.174.169 |                  | idle   | 2025-02-11 12:06:06.193467-04 | 2026-02-24 15:23:45.200496-04 | Client          | ClientRead
 3840124 | zabbix      | zabbix  | 180.183.174.169 |                  | idle   | 2025-02-11 12:06:06.063083-04 | 2026-02-24 15:23:43.121373-04 | Client          | ClientRead
 3840152 | zabbix      | zabbix  | 180.183.174.169 |                  | idle   | 2025-02-11 12:06:06.287028-04 | 2026-02-24 15:23:42.383394-04 | Client          | ClientRead
 4142381 | zbx_monitor | zabbix  | 180.183.174.170 |                  | idle   | 2025-02-24 12:22:11.094105-04 | 2026-02-24 15:23:35.399403-04 | Client          | ClientRead
 3840153 | zabbix      | zabbix  | 180.183.174.169 |                  | idle   | 2025-02-11 12:06:06.287224-04 | 2026-02-24 15:23:34.415858-04 | Client          | ClientRead
 3840150 | zabbix      | zabbix  | 180.183.174.169 |                  | idle   | 2025-02-11 12:06:06.206122-04 | 2026-02-24 15:23:15.879842-04 | Client          | ClientRead
 3840146 | zabbix      | zabbix  | 180.183.174.169 |                  | idle   | 2025-02-11 12:06:06.201466-04 | 2026-02-24 15:23:13.344313-04 | Client          | ClientRead
 3840147 | zabbix      | zabbix  | 180.183.174.169 |                  | idle   | 2025-02-11 12:06:06.203545-04 | 2026-02-24 15:15:27.712575-04 | Client          | ClientRead
 3840142 | zabbix      | zabbix  | 180.183.174.169 |                  | idle   | 2025-02-11 12:06:06.197854-04 | 2026-02-24 15:00:27.701914-04 | Client          | ClientRead
 3840138 | zabbix      | zabbix  | 180.183.174.169 |                  | idle   | 2025-02-11 12:06:06.195779-04 | 2026-02-24 14:15:27.668602-04 | Client          | ClientRead
 3840139 | zabbix      | zabbix  | 180.183.174.169 |                  | idle   | 2025-02-11 12:06:06.196469-04 | 2026-02-24 14:00:27.664138-04 | Client          | ClientRead
 3840141 | zabbix      | zabbix  | 180.183.174.169 |                  | idle   | 2025-02-11 12:06:06.197105-04 | 2026-02-24 12:57:13.206384-04 | Client          | ClientRead
 3840143 | zabbix      | zabbix  | 180.183.174.169 |                  | idle   | 2025-02-11 12:06:06.198632-04 | 2026-02-12 14:56:30.038671-04 | Client          | ClientRead
 3840145 | zabbix      | zabbix  | 180.183.174.169 |                  | idle   | 2025-02-11 12:06:06.200651-04 | 2026-02-12 14:56:28.031947-04 | Client          | ClientRead
 3840140 | zabbix      | zabbix  | 180.183.174.169 |                  | idle   | 2025-02-11 12:06:06.196616-04 | 2025-02-11 12:06:59.275734-04 | Client          | ClientRead
 3840148 | zabbix      | zabbix  | 180.183.174.169 |                  | idle   | 2025-02-11 12:06:06.205033-04 | 2025-02-11 12:06:47.263818-04 | Client          | ClientRead
 3840144 | zabbix      | zabbix  | 180.183.174.169 |                  | idle   | 2025-02-11 12:06:06.200505-04 | 2025-02-11 12:06:43.25952-04  | Client          | ClientRead
 3840137 | zabbix      | zabbix  | 180.183.174.169 |                  | idle   | 2025-02-11 12:06:06.194525-04 | 2025-02-11 12:06:06.220327-04 | Client          | ClientRead
 3840132 | zabbix      | zabbix  | 180.183.174.169 |                  | idle   | 2025-02-11 12:06:06.189836-04 | 2025-02-11 12:06:06.212156-04 | Client          | ClientRead
 3840129 | zabbix      | zabbix  | 180.183.174.169 |                  | idle   | 2025-02-11 12:06:06.18856-04  | 2025-02-11 12:06:06.20558-04  | Client          | ClientRead


-Puerto en que opera
5455

-Espacio total en disco de la BD
1.9G    /postgres/data

-La BD cuenta con TimescaleDB (Que version) o algún particionamiento manual?