**********************************************************************************
Servidor ORIGEN
Name:   clbdmdbpp01.banvenqa.com
Address: 180.183.170.108
ssh mariadb@clbdmdbpp01.banvenqa.com

**********************************************************************************

--Consultar el filesystem mariadb/backup

df -h

-- Entrar en la ruta donde se guardan los .sql.gz (backup)
cd /mariadb/backup/dump

-- Revisar el crontab y ejecutar:
crontab -l

sh /home/mariadb/utils/scripts/dump_database.sh paginapublica wordpress_qa
-- Listar los archivos y descargar el ultimo archivo.

**********************************************************************************
Servidor DESTINO
Name:   plbdmdbpp01.banvenez.corp
Address: 172.27.67.103
**********************************************************************************
--Realizar un backup previamente

sh /home/mariadb/utils/scripts/dump_database.sh paginapublica wordpress


-- Subir el backup de qa al servidor de PRODUCCIÓN a la ruta  /mariadb/backup/restore


--Descomprimir el backup.
cd /mariadb/backup/restore

--gzip -d archivo_descargado.sql.gz
--paginapublica_connect wordpress < archivo_descargado.sql
gzip -d dump_paginapublica_20260203-2100.sql.gz


--Conectarse a la BD
paginapublica_connect

--Listar las Base de Datos --mariadb@(none)>
show databases;

--Borrar BD
drop database wordpress;

--Recrear la Base de Datos

create database wordpress;
show databases;
exit;

**********************************************************************************

paginapublica_connect wordpress < dump_paginapublica_20260203-2100.sql

--Conectarse a la BD --mariadb@(none)>
paginapublica_connect

show databases;
use wordpress;
show tables;
**********************************************************************************

---Consultas verificación:

SELECT id, referer, referer_title from wp_e_submissions;

SELECT * FROM wp_e_submissions_values WHERE submission_id IN (67013);






**********************************************************************************


Database changed
21:08:35 mariadb@wordpress>show tables;
+---------------------------------------------+
| Tables_in_wordpress                         |
+---------------------------------------------+
| tasa                                        |
| version                                     |
| wp_actionscheduler_actions                  |
| wp_actionscheduler_claims                   |
| wp_actionscheduler_groups                   |
| wp_actionscheduler_logs                     |
| wp_asl_brands                               |
| wp_asl_categories                           |
| wp_asl_configs                              |
| wp_asl_countries                            |
| wp_asl_markers                              |
| wp_asl_settings                             |
| wp_asl_specials                             |
| wp_asl_storelogos                           |
| wp_asl_stores                               |
| wp_asl_stores_categories                    |
| wp_asl_stores_meta                          |
| wp_asl_stores_view                          |
| wp_commentmeta                              |
| wp_comments                                 |
| wp_cp_calculated_fields_form_discount_codes |
| wp_cp_calculated_fields_form_posts          |
| wp_cp_calculated_fields_form_revision       |
| wp_cp_calculated_fields_form_settings       |
| wp_ditty_itemmeta                           |
| wp_ditty_items                              |
| wp_e_events                                 |
| wp_e_notes                                  |
| wp_e_notes_users_relations                  |
| wp_e_submissions                            |
| wp_e_submissions_actions_log                |
| wp_e_submissions_values                     |
| wp_export_page_to_html_logs                 |
| wp_export_urls_logs                         |
| wp_hfcm_scripts                             |
| wp_links                                    |
| wp_nextend2_image_storage                   |
| wp_nextend2_section_storage                 |
| wp_nextend2_smartslider3_generators         |
| wp_nextend2_smartslider3_sliders            |
| wp_nextend2_smartslider3_sliders_xref       |
| wp_nextend2_smartslider3_slides             |
| wp_options                                  |
| wp_postmeta                                 |
| wp_posts                                    |
| wp_simply_static_pages                      |
| wp_tec_events                               |
| wp_tec_occurrences                          |
| wp_term_relationships                       |
| wp_term_taxonomy                            |
| wp_termmeta                                 |
| wp_terms                                    |
| wp_usermeta                                 |
| wp_users                                    |
| wp_wow_coder                                |
| wp_wpfm_backup                              |
+---------------------------------------------+
56 rows in set (0.000 sec)


21:11:12 mariadb@wordpress>show tables;
+---------------------------------------------+
| Tables_in_wordpress                         |
+---------------------------------------------+
| tasa                                        |
| version                                     |
| wp_actionscheduler_actions                  |
| wp_actionscheduler_claims                   |
| wp_actionscheduler_groups                   |
| wp_actionscheduler_logs                     |
| wp_asl_brands                               |
| wp_asl_categories                           |
| wp_asl_configs                              |
| wp_asl_countries                            |
| wp_asl_markers                              |
| wp_asl_settings                             |
| wp_asl_specials                             |
| wp_asl_storelogos                           |
| wp_asl_stores                               |
| wp_asl_stores_categories                    |
| wp_asl_stores_meta                          |
| wp_asl_stores_view                          |
| wp_commentmeta                              |
| wp_comments                                 |
| wp_cp_calculated_fields_form_discount_codes |
| wp_cp_calculated_fields_form_posts          |
| wp_cp_calculated_fields_form_revision       |
| wp_cp_calculated_fields_form_settings       |
| wp_ditty_itemmeta                           |
| wp_ditty_items                              |
| wp_e_events                                 |
| wp_e_notes                                  |
| wp_e_notes_users_relations                  |
| wp_e_submissions                            |
| wp_e_submissions_actions_log                |
| wp_e_submissions_values                     |
| wp_export_page_to_html_logs                 |
| wp_export_urls_logs                         |
| wp_hfcm_scripts                             |
| wp_links                                    |
| wp_nextend2_image_storage                   |
| wp_nextend2_section_storage                 |
| wp_nextend2_smartslider3_generators         |
| wp_nextend2_smartslider3_sliders            |
| wp_nextend2_smartslider3_sliders_xref       |
| wp_nextend2_smartslider3_slides             |
| wp_options                                  |
| wp_postmeta                                 |
| wp_posts                                    |
| wp_simply_static_pages                      |
| wp_tec_events                               |
| wp_tec_occurrences                          |
| wp_term_relationships                       |
| wp_term_taxonomy                            |
| wp_termmeta                                 |
| wp_terms                                    |
| wp_usermeta                                 |
| wp_users                                    |
| wp_wow_coder                                |
| wp_wpfm_backup                              |
+---------------------------------------------+
56 rows in set (0.000 sec)
