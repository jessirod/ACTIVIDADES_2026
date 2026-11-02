**********************************************************
RESTORE
**********************************************************
oracle12@sun2006p:/oracle12$ rman target /

Recovery Manager: Release 12.2.0.1.0 - Production on Mon Apr 20 15:44:01 2026

Copyright (c) 1982, 2017, Oracle and/or its affiliates.  All rights reserved.

connected to target database: PCP (DBID=2447070573, not open)
RMAN> RUN
{
    allocate channel ch1 d2> 3> evice type sbt_tape ;
    alloca4> te channel ch2 device type sbt_tape ;
    allocate channel ch3 d5> evice type sbt_tape ;
    alloca6> te channel ch4 device type sbt_tape ;
    SET UNTIL TIME "to_dat7> e('06-MAR-2025 15:46:07','dd-mm-yyyy hh24:mi:ss')";
        send 'SBT_P8> ARMS=(NSR_SERVER=cpprwnetworkerp,NSR_STORAGE_NODE=plsnwk01,NSR_DATA_VOLUME_POOL=PCP_ONL_MENSUAL,NSR_CLIENT=sun2317p)';
    RESTO9> RE database;
    release channel10>  ch1 ;
    release channel ch2 ;11>
    release channel ch3 ;
    r12> 13> elease channel ch4 ;
}14>

using target database control file instead of recovery catalog
allocated channel: ch1
channel ch1: SID=2824 device type=SBT_TAPE
channel ch1: NMDA Oracle v19.2.1.3

allocated channel: ch2
channel ch2: SID=3763 device type=SBT_TAPE
channel ch2: NMDA Oracle v19.2.1.3

allocated channel: ch3
channel ch3: SID=11283 device type=SBT_TAPE
channel ch3: NMDA Oracle v19.2.1.3

allocated channel: ch4
channel ch4: SID=12224 device type=SBT_TAPE
channel ch4: NMDA Oracle v19.2.1.3

executing command: SET until clause

sent command to channel: ch1
sent command to channel: ch2
sent command to channel: ch3
sent command to channel: ch4

Starting restore at 21-APR-2026 11:02:29
Starting implicit crosscheck backup at 21-APR-2026 11:02:29
Crosschecked 177 objects
Finished implicit crosscheck backup at 21-APR-2026 11:02:46

Starting implicit crosscheck copy at 21-APR-2026 11:02:46
Finished implicit crosscheck copy at 21-APR-2026 11:02:48

searching for all files in the recovery area
cataloging files...
no files cataloged


new media label is "BO4860L9" for piece "t53jlulm_1_1"
new media label is "BO4860L9" for piece "t63jlulm_1_1"
new media label is "BO4860L9" for piece "t73jlulm_1_1"
new media label is "BO4861L9" for piece "tf3jluvm_1_1"
new media label is "BO4861L9" for piece "tg3jlv2v_1_1"
new media label is "BO4861L9" for piece "th3jlv42_1_1"
new media label is "BO4861L9" for piece "ti3jlv4i_1_1"
new media label is "BO4861L9" for piece "tj3jlv5l_1_1"
new media label is "BO4861L9" for piece "tk3jlv7c_1_1"
new media label is "BO4861L9" for piece "tl3jlv8f_1_1"
new media label is "BO4861L9" for piece "tm3jlv8u_1_1"
new media label is "BO4861L9" for piece "tn3jlva1_1_1"
new media label is "BO4861L9" for piece "to3jlvbp_1_1"
new media label is "BO4860L9" for piece "t83jlulm_1_1"
new media label is "BO4861L9" for piece "t93jluqh_1_1"
new media label is "BO4861L9" for piece "tp3jlvcs_1_1"
new media label is "BO4861L9" for piece "ta3jluqh_1_1"
new media label is "BO4861L9" for piece "tq3jlvdb_1_1"
new media label is "BO4861L9" for piece "tr3jlvee_1_1"
new media label is "BO4861L9" for piece "ts3jlvg5_1_1"
new media label is "BO4861L9" for piece "tt3jlvh8_1_1"
new media label is "BO4861L9" for piece "tu3jlvho_1_1"
new media label is "BO4861L9" for piece "tv3jlvir_1_1"
new media label is "BO4861L9" for piece "u03jlvks_1_1"
new media label is "BO4861L9" for piece "u13jlvlv_1_1"
new media label is "BO4861L9" for piece "u23jlvm6_1_1"
new media label is "BO4861L9" for piece "u33jlvna_1_1"
new media label is "BO4861L9" for piece "u43jlvpb_1_1"
new media label is "BO4861L9" for piece "u53jlvqe_1_1"
new media label is "BO4861L9" for piece "u63jlvql_1_1"
new media label is "BO4861L9" for piece "u73jlvs2_1_1"
new media label is "BO4861L9" for piece "u83jlvtp_1_1"
new media label is "BO4861L9" for piece "u93jlvv7_1_1"
new media label is "BO4861L9" for piece "ua3jlvv7_1_1"
new media label is "BO4860L9" for piece "ub3jm00k_1_1"
new media label is "BO4860L9" for piece "uc3jm02b_1_1"
new media label is "BO4860L9" for piece "ud3jm03o_1_1"
new media label is "BO4860L9" for piece "ue3jm03o_1_1"
new media label is "BO4860L9" for piece "uf3jm056_1_1"
new media label is "BO4860L9" for piece "ug3jm06t_1_1"
new media label is "BO4860L9" for piece "uh3jm08a_1_1"
new media label is "BO4860L9" for piece "ui3jm08a_1_1"
new media label is "BO4860L9" for piece "uj3jm09n_1_1"
new media label is "BO4860L9" for piece "uk3jm0be_1_1"
new media label is "BO4860L9" for piece "ul3jm0cs_1_1"
new media label is "BO4860L9" for piece "um3jm0cs_1_1"
new media label is "BO4860L9" for piece "un3jm0e9_1_1"
new media label is "BO4860L9" for piece "uo3jm0g0_1_1"
new media label is "BO4860L9" for piece "up3jm0hd_1_1"
new media label is "BO4860L9" for piece "uq3jm0hd_1_1"
new media label is "BO4860L9" for piece "ur3jm0ir_1_1"
new media label is "BO4860L9" for piece "us3jm0ki_1_1"
new media label is "BO4860L9" for piece "ut3jm0lv_1_1"
new media label is "BO4860L9" for piece "393jm570_1_1"
new media label is "BO4860L9" for piece "uu3jm0lv_1_1"
new media label is "BO4860L9" for piece "uv3jm0nc_1_1"
new media label is "BO4860L9" for piece "v03jm0p3_1_1"
new media label is "BO4860L9" for piece "v13jm0qh_1_1"
new media label is "BO4860L9" for piece "v23jm0qh_1_1"
new media label is "BO4860L9" for piece "v33jm0ru_1_1"
new media label is "BO4860L9" for piece "v43jm0tl_1_1"
new media label is "BO4860L9" for piece "v53jm0uo_1_1"
new media label is "BO4860L9" for piece "v63jm0v0_1_1"
new media label is "BO4860L9" for piece "v73jm10d_1_1"
new media label is "BO4860L9" for piece "v83jm124_1_1"
new media label is "BO4860L9" for piece "v93jm137_1_1"
new media label is "BO4860L9" for piece "va3jm13m_1_1"
new media label is "BO4860L9" for piece "vb3jm153_1_1"
new media label is "BO4860L9" for piece "vc3jm16r_1_1"
new media label is "BO4860L9" for piece "vd3jm17u_1_1"
new media label is "BO4860L9" for piece "ve3jm18d_1_1"
new media label is "BO4860L9" for piece "vf3jm19q_1_1"
new media label is "BO4860L9" for piece "vg3jm1bh_1_1"
new media label is "BO4860L9" for piece "vh3jm1ck_1_1"
new media label is "BO4860L9" for piece "vi3jm1d4_1_1"
new media label is "BO4860L9" for piece "vj3jm1eh_1_1"
new media label is "BO4860L9" for piece "vk3jm1g8_1_1"
new media label is "BO4860L9" for piece "vl3jm1hb_1_1"
new media label is "BO4860L9" for piece "vm3jm1hq_1_1"
new media label is "BO4860L9" for piece "vn3jm1j7_1_1"
new media label is "BO4861L9" for piece "vo3jm1kv_1_1"
new media label is "BO4861L9" for piece "vp3jm1m2_1_1"
new media label is "BO4861L9" for piece "vq3jm1mh_1_1"
new media label is "BO4861L9" for piece "vr3jm1nu_1_1"
new media label is "BO4861L9" for piece "vs3jm1pl_1_1"
new media label is "BO4861L9" for piece "vt3jm1qp_1_1"
new media label is "BO4861L9" for piece "vu3jm1r8_1_1"
new media label is "BO4861L9" for piece "vv3jm1sl_1_1"
new media label is "BO4861L9" for piece "003jm1uc_1_1"
new media label is "BO4861L9" for piece "013jm1vf_1_1"
new media label is "BO4861L9" for piece "023jm208_1_1"
new media label is "BO4861L9" for piece "033jm21c_1_1"
new media label is "BO4861L9" for piece "043jm233_1_1"
new media label is "BO4861L9" for piece "053jm246_1_1"
new media label is "BO4861L9" for piece "063jm24v_1_1"
new media label is "BO4861L9" for piece "073jm262_1_1"
new media label is "BO4861L9" for piece "083jm27q_1_1"
new media label is "BO4861L9" for piece "093jm28j_1_1"
new media label is "BO4861L9" for piece "0a3jm29m_1_1"
new media label is "BO4861L9" for piece "0b3jm2af_1_1"
new media label is "BO4861L9" for piece "0c3jm2cg_1_1"
new media label is "BO4861L9" for piece "0d3jm2d9_1_1"
new media label is "BO4861L9" for piece "0e3jm2ed_1_1"
new media label is "BO4861L9" for piece "0f3jm2es_1_1"
new media label is "BO4861L9" for piece "0g3jm2h7_1_1"
new media label is "BO4861L9" for piece "0h3jm2hm_1_1"
new media label is "BO4861L9" for piece "0i3jm2ip_1_1"
new media label is "BO4861L9" for piece "0j3jm2j9_1_1"
new media label is "BO4860L9" for piece "0k3jm2la_1_1"
new media label is "BO4860L9" for piece "0l3jm2lp_1_1"
new media label is "BO4860L9" for piece "0m3jm2ms_1_1"
new media label is "BO4860L9" for piece "0n3jm2ms_1_1"
new media label is "BO4860L9" for piece "0o3jm2ot_1_1"
new media label is "BO4860L9" for piece "0p3jm2pd_1_1"
new media label is "BO4837L9" for piece "353jm541_1_1"
new media label is "BO4861L9" for piece "373jm541_1_1"
new media label is "BO4837L9" for piece "0q3jm2qg_1_1"
new media label is "BO4860L9" for piece "3e3jm5ag_1_1"
new media label is "BO4837L9" for piece "3d3jm5ac_1_1"
new media label is "BO4861L9" for piece "363jm541_1_1"
new media label is "BO4860L9" for piece "0r3jm2qg_1_1"
new media label is "BO4837L9" for piece "343jm53h_1_1"
new media label is "BO4860L9" for piece "383jm570_1_1"
new media label is "BO4837L9" for piece "3g3jm5da_1_1"
new media label is "BO4860L9" for piece "3f3jm5av_1_1"
new media label is "BO4860L9" for piece "0s3jm2sh_1_1"
new media label is "BO4860L9" for piece "0t3jm2ta_1_1"
new media label is "BO4860L9" for piece "0u3jm2th_1_1"
new media label is "BO4861L9" for piece "3h3jm5dp_1_1"
new media label is "BO4861L9" for piece "3i3jm5e8_1_1"
new media label is "BO4861L9" for piece "3j3jm5e9_1_1"
new media label is "BO4860L9" for piece "3a3jm57q_1_1"
new media label is "BO4860L9" for piece "3b3jm57q_1_1"
new media label is "BO4860L9" for piece "3c3jm5a5_1_1"
new media label is "BO4861L9" for piece "3q3jm5kn_1_1"
new media label is "BO4860L9" for piece "0v3jm2ub_1_1"
new media label is "BO4860L9" for piece "103jm302_1_1"
new media label is "BO4860L9" for piece "113jm302_1_1"
new media label is "BO4860L9" for piece "123jm309_1_1"
new media label is "BO4861L9" for piece "3k3jm5gk_1_1"
new media label is "BO4861L9" for piece "133jm30g_1_1"
new media label is "BO4861L9" for piece "143jm327_1_1"
new media label is "BO4861L9" for piece "153jm33v_1_1"
new media label is "BO4861L9" for piece "163jm34o_1_1"
new media label is "BO4861L9" for piece "173jm34o_1_1"
new media label is "BO4861L9" for piece "183jm34o_1_1"
new media label is "BO4861L9" for piece "193jm38b_1_1"
new media label is "BO4861L9" for piece "1a3jm39f_1_1"
new media label is "BO4861L9" for piece "1b3jm39f_1_1"
new media label is "BO4861L9" for piece "1c3jm39u_1_1"
new media label is "BO4861L9" for piece "1d3jm3d7_1_1"
new media label is "BO4861L9" for piece "1e3jm3ea_1_1"
new media label is "BO4861L9" for piece "1f3jm3ea_1_1"
new media label is "BO4861L9" for piece "1g3jm3eq_1_1"
new media label is "BO4861L9" for piece "1h3jm3i3_1_1"
new media label is "BO4861L9" for piece "1i3jm3is_1_1"
new media label is "BO4861L9" for piece "1j3jm3is_1_1"
new media label is "BO4861L9" for piece "1k3jm3jb_1_1"
new media label is "BO4861L9" for piece "1l3jm3n8_1_1"
new media label is "BO4861L9" for piece "1m3jm3nc_1_1"
new media label is "BO4861L9" for piece "1n3jm3nd_1_1"
new media label is "BO4861L9" for piece "1o3jm3ns_1_1"
new media label is "BO4861L9" for piece "1p3jm3rp_1_1"
new media label is "BO4861L9" for piece "1q3jm3rp_1_1"
new media label is "BO4861L9" for piece "1r3jm3s1_1_1"
new media label is "BO4861L9" for piece "1s3jm3sg_1_1"
new media label is "BO4861L9" for piece "1t3jm40d_1_1"
new media label is "BO4861L9" for piece "1u3jm40d_1_1"
new media label is "BO4861L9" for piece "1v3jm40s_1_1"
new media label is "BO4861L9" for piece "203jm40v_1_1"
new media label is "BO4861L9" for piece "213jm457_1_1"
new media label is "BO4861L9" for piece "223jm457_1_1"
new media label is "BO4861L9" for piece "233jm45a_1_1"
new media label is "BO4837L9" for piece "3l3jm5hd_1_1"
new media label is "BO4837L9" for piece "3m3jm5hk_1_1"
new media label is "BO4861L9" for piece "243jm45p_1_1"
new media label is "BO4861L9" for piece "253jm46s_1_1"
new media label is "BO4861L9" for piece "263jm48u_1_1"
new media label is "BO4861L9" for piece "273jm4a1_1_1"
new media label is "BO4861L9" for piece "283jm4ag_1_1"
new media label is "BO4861L9" for piece "293jm4bj_1_1"
new media label is "BO4861L9" for piece "2a3jm4dk_1_1"
new media label is "BO4861L9" for piece "2b3jm4fb_1_1"
new media label is "BO4861L9" for piece "tb3jluqo_1_1"
new media label is "BO4861L9" for piece "tc3jluto_1_1"
new media label is "BO4861L9" for piece "td3jluvf_1_1"
new media label is "BO4861L9" for piece "te3jluvf_1_1"
new media label is "BO4861L9" for piece "2c3jm4gf_1_1"
new media label is "BO4861L9" for piece "2d3jm4gu_1_1"
new media label is "BO4861L9" for piece "2e3jm4ib_1_1"
new media label is "BO4860L9" for piece "2f3jm4jo_1_1"
new media label is "BO4860L9" for piece "2g3jm4kh_1_1"
new media label is "BO4860L9" for piece "2h3jm4l1_1_1"
new media label is "BO4860L9" for piece "2i3jm4mo_1_1"
new media label is "BO4860L9" for piece "2j3jm4o5_1_1"
new media label is "BO4837L9" for piece "3n3jm5hl_1_1"
new media label is "BO4861L9" for piece "2k3jm4ok_1_1"
new media label is "BO4861L9" for piece "2l3jm4pd_1_1"
new media label is "BO4861L9" for piece "2m3jm4rf_1_1"
new media label is "BO4861L9" for piece "2n3jm4rf_1_1"
new media label is "BO4861L9" for piece "2o3jm4t6_1_1"
new media label is "BO4860L9" for piece "2p3jm4uj_1_1"
new media label is "BO4860L9" for piece "2q3jm4uj_1_1"
new media label is "BO4860L9" for piece "2r3jm501_1_1"
new media label is "BO4860L9" for piece "2s3jm501_1_1"
new media label is "BO4860L9" for piece "2t3jm51e_1_1"
new media label is "BO4861L9" for piece "3o3jm5j3_1_1"
new media label is "BO4860L9" for piece "2u3jm51e_1_1"
new media label is "BO4860L9" for piece "2v3jm51t_1_1"
new media label is "BO4860L9" for piece "303jm52d_1_1"
new media label is "BO4861L9" for piece "313jm52k_1_1"
new media label is "BO4861L9" for piece "323jm52r_1_1"
new media label is "BO4861L9" for piece "3p3jm5kg_1_1"
new media label is "BO4861L9" for piece "3r3jm5ku_1_1"
new media label is "BO4861L9" for piece "3s3jm5l5_1_1"
new media label is "BO4861L9" for piece "3t3jm5lk_1_1"
new media label is "BO4861L9" for piece "333jm532_1_1"
new media label is "BO4861L9" for piece "3u3jm5ll_1_1"
channel ch1: starting datafile backup set restore
channel ch1: specifying datafile(s) to restore from backup set
channel ch1: restoring datafile 00004 to +DG_DATA/PCP/DATAFILE/undotbs1.258.1018885305
channel ch1: reading from backup piece t73jlulm_1_1
channel ch2: starting datafile backup set restore
channel ch2: specifying datafile(s) to restore from backup set
channel ch2: restoring datafile 00019 to +DG_DATA/PCP/DATAFILE/undotbs1.274.1066045441
channel ch2: reading from backup piece t83jlulm_1_1
channel ch3: starting datafile backup set restore
channel ch3: specifying datafile(s) to restore from backup set
channel ch3: restoring datafile 00003 to +DG_DATA/PCP/DATAFILE/sysaux.257.1018885269
channel ch3: reading from backup piece t63jlulm_1_1
channel ch4: starting datafile backup set restore
channel ch4: specifying datafile(s) to restore from backup set
channel ch4: restoring datafile 00001 to +DG_DATA/PCP/DATAFILE/system.256.1018885215
channel ch4: restoring datafile 00002 to +DG_DATA/PCP/DATAFILE/data.263.1018953447
channel ch4: restoring datafile 00005 to +DG_DATA/PCP/DATAFILE/data_auditoria.262.1018951061
channel ch4: restoring datafile 00007 to +DG_DATA/PCP/DATAFILE/users.259.1018885305
channel ch4: restoring datafile 00008 to +DG_ENTRY/PCP/DATAFILE/ts_entry.256.1024849981
channel ch4: restoring datafile 00142 to +DG_DATA/PCP/DATAFILE/data.395.1147431765
channel ch4: restoring datafile 00156 to /oracle/app/oracle12/product/12.2.0/db_1/dbs/k3r3p4kup41
channel ch4: restoring datafile 00157 to +DG_DATA/PCP/DATAFILE/data.424.1158942721
channel ch4: restoring datafile 00176 to +DG_DATA/PCP/DATAFILE/indx_pcp.444.1163287495
channel ch4: reading from backup piece t53jlulm_1_1
channel ch2: piece handle=t83jlulm_1_1 tag=PCP_ONL_MENSUAL
channel ch2: restored backup piece 1
channel ch2: restore complete, elapsed time: 01:10:48
channel ch2: starting datafile backup set restore
channel ch2: specifying datafile(s) to restore from backup set
channel ch2: restoring datafile 00020 to +DG_DATA/PCP/DATAFILE/undotbs1.275.1066045875
channel ch2: reading from backup piece t93jluqh_1_1
channel ch4: piece handle=t53jlulm_1_1 tag=PCP_ONL_MENSUAL
channel ch4: restored backup piece 1
channel ch4: restore complete, elapsed time: 01:18:03
channel ch4: starting datafile backup set restore
channel ch4: specifying datafile(s) to restore from backup set
channel ch4: restoring datafile 00022 to +DG_DATA/PCP/DATAFILE/undotbs1.277.1066061169
channel ch4: reading from backup piece ta3jluqh_1_1
channel ch3: piece handle=t63jlulm_1_1 tag=PCP_ONL_MENSUAL
channel ch3: restored backup piece 1
channel ch3: restore complete, elapsed time: 01:20:09
channel ch3: starting datafile backup set restore
channel ch3: specifying datafile(s) to restore from backup set
channel ch3: restoring datafile 00213 to +DG_DATA/PCP/DATAFILE/sysaux.481.1169720053
channel ch3: reading from backup piece tb3jluqo_1_1
channel ch3: piece handle=tb3jluqo_1_1 tag=PCP_ONL_MENSUAL
channel ch3: restored backup piece 1
channel ch3: restore complete, elapsed time: 00:12:15
channel ch3: starting datafile backup set restore
channel ch3: specifying datafile(s) to restore from backup set
channel ch3: restoring datafile 00214 to +DG_DATA/PCP/DATAFILE/sysaux.482.1169950723
channel ch3: reading from backup piece tc3jluto_1_1
channel ch3: piece handle=tc3jluto_1_1 tag=PCP_ONL_MENSUAL
channel ch3: restored backup piece 1
channel ch3: restore complete, elapsed time: 00:07:35
channel ch3: starting datafile backup set restore
channel ch3: specifying datafile(s) to restore from backup set
channel ch3: restoring datafile 00009 to +DG_DATA/PCP/DATAFILE/ts_history.265.1018974041
channel ch3: reading from backup piece tf3jluvm_1_1
channel ch3: piece handle=tf3jluvm_1_1 tag=PCP_ONL_MENSUAL
channel ch3: restored backup piece 1
channel ch3: restore complete, elapsed time: 00:05:36
channel ch3: starting datafile backup set restore
channel ch3: specifying datafile(s) to restore from backup set
channel ch3: restoring datafile 00216 to +DG_DATA/PCP/DATAFILE/sysaux.484.1170546143
channel ch3: reading from backup piece te3jluvf_1_1
channel ch3: piece handle=te3jluvf_1_1 tag=PCP_ONL_MENSUAL
channel ch3: restored backup piece 1
channel ch3: restore complete, elapsed time: 00:06:15
channel ch3: starting datafile backup set restore
channel ch3: specifying datafile(s) to restore from backup set
channel ch3: restoring datafile 00215 to +DG_DATA/PCP/DATAFILE/sysaux.483.1170202303
channel ch3: reading from backup piece td3jluvf_1_1
channel ch3: piece handle=td3jluvf_1_1 tag=PCP_ONL_MENSUAL
channel ch3: restored backup piece 1
channel ch3: restore complete, elapsed time: 00:06:35
channel ch3: starting datafile backup set restore
channel ch3: specifying datafile(s) to restore from backup set
channel ch3: restoring datafile 00010 to +DG_MODEL/PCP/DATAFILE/ts_tx.256.1024849759
channel ch3: reading from backup piece tg3jlv2v_1_1
channel ch3: piece handle=tg3jlv2v_1_1 tag=PCP_ONL_MENSUAL
channel ch3: restored backup piece 1
channel ch3: restore complete, elapsed time: 00:05:06
channel ch3: starting datafile backup set restore
channel ch3: specifying datafile(s) to restore from backup set
channel ch3: restoring datafile 00011 to +DG_MODEL/PCP/DATAFILE/ts_tx.257.1026835029
channel ch3: reading from backup piece th3jlv42_1_1
channel ch3: piece handle=th3jlv42_1_1 tag=PCP_ONL_MENSUAL
channel ch3: restored backup piece 1
channel ch3: restore complete, elapsed time: 00:06:45
channel ch3: starting datafile backup set restore
channel ch3: specifying datafile(s) to restore from backup set
channel ch3: restoring datafile 00012 to +DG_DATA/PCP/DATAFILE/ts_history.264.1026835107
channel ch3: reading from backup piece ti3jlv4i_1_1
channel ch3: piece handle=ti3jlv4i_1_1 tag=PCP_ONL_MENSUAL
channel ch3: restored backup piece 1
channel ch3: restore complete, elapsed time: 00:05:05
channel ch3: starting datafile backup set restore
channel ch3: specifying datafile(s) to restore from backup set
channel ch3: restoring datafile 00013 to +DG_DATA/PCP/DATAFILE/ts_user.266.1026835453
channel ch3: reading from backup piece tj3jlv5l_1_1
channel ch3: piece handle=tj3jlv5l_1_1 tag=PCP_ONL_MENSUAL
channel ch3: restored backup piece 1
channel ch3: restore complete, elapsed time: 00:06:36
channel ch3: starting datafile backup set restore
channel ch3: specifying datafile(s) to restore from backup set
channel ch3: restoring datafile 00014 to +DG_DATA/PCP/DATAFILE/ts_history.267.1047217381
channel ch3: reading from backup piece tk3jlv7c_1_1
channel ch3: piece handle=tk3jlv7c_1_1 tag=PCP_ONL_MENSUAL
channel ch3: restored backup piece 1
channel ch3: restore complete, elapsed time: 00:06:45
channel ch3: starting datafile backup set restore
channel ch3: specifying datafile(s) to restore from backup set
channel ch3: restoring datafile 00015 to +DG_MODEL/PCP/DATAFILE/ts_tx.258.1057569715
channel ch3: reading from backup piece tl3jlv8f_1_1
channel ch3: piece handle=tl3jlv8f_1_1 tag=PCP_ONL_MENSUAL
channel ch3: restored backup piece 1
channel ch3: restore complete, elapsed time: 00:07:35
channel ch3: starting datafile backup set restore
channel ch3: specifying datafile(s) to restore from backup set
channel ch3: restoring datafile 00016 to +DG_DATA/PCP/DATAFILE/ts_user.271.1060761387
channel ch3: reading from backup piece tm3jlv8u_1_1
channel ch4: piece handle=ta3jluqh_1_1 tag=PCP_ONL_MENSUAL
channel ch4: restored backup piece 1
channel ch4: restore complete, elapsed time: 01:19:29
channel ch4: starting datafile backup set restore
channel ch4: specifying datafile(s) to restore from backup set
channel ch4: restoring datafile 00017 to +DG_DATA/PCP/DATAFILE/ts_user.272.1061925599
channel ch4: reading from backup piece tn3jlva1_1_1
channel ch4: piece handle=tn3jlva1_1_1 tag=PCP_ONL_MENSUAL
channel ch4: restored backup piece 1
channel ch4: restore complete, elapsed time: 00:06:26
channel ch4: starting datafile backup set restore
channel ch4: specifying datafile(s) to restore from backup set
channel ch4: restoring datafile 00018 to +DG_DATA/PCP/DATAFILE/data.273.1065192055
channel ch4: reading from backup piece to3jlvbp_1_1
channel ch4: piece handle=to3jlvbp_1_1 tag=PCP_ONL_MENSUAL
channel ch4: restored backup piece 1
channel ch4: restore complete, elapsed time: 00:06:05
channel ch4: starting datafile backup set restore
channel ch4: specifying datafile(s) to restore from backup set
channel ch4: restoring datafile 00021 to +DG_DATA/PCP/DATAFILE/data.276.1066046175
channel ch4: reading from backup piece tp3jlvcs_1_1
channel ch4: piece handle=tp3jlvcs_1_1 tag=PCP_ONL_MENSUAL
channel ch4: restored backup piece 1
channel ch4: restore complete, elapsed time: 00:04:45
channel ch4: starting datafile backup set restore
channel ch4: specifying datafile(s) to restore from backup set
channel ch4: restoring datafile 00023 to +DG_DATA/PCP/DATAFILE/data.279.1081535793
channel ch4: reading from backup piece tq3jlvdb_1_1
channel ch4: piece handle=tq3jlvdb_1_1 tag=PCP_ONL_MENSUAL
channel ch4: restored backup piece 1
channel ch4: restore complete, elapsed time: 00:04:46
channel ch4: starting datafile backup set restore
channel ch4: specifying datafile(s) to restore from backup set
channel ch4: restoring datafile 00024 to +DG_DATA/PCP/DATAFILE/data.280.1085400845
channel ch4: reading from backup piece tr3jlvee_1_1
channel ch4: piece handle=tr3jlvee_1_1 tag=PCP_ONL_MENSUAL
channel ch4: restored backup piece 1
channel ch4: restore complete, elapsed time: 00:03:45
channel ch4: starting datafile backup set restore
channel ch4: specifying datafile(s) to restore from backup set
channel ch4: restoring datafile 00025 to +DG_DATA/PCP/DATAFILE/data.281.1088784473
channel ch4: reading from backup piece ts3jlvg5_1_1
channel ch4: piece handle=ts3jlvg5_1_1 tag=PCP_ONL_MENSUAL
channel ch4: restored backup piece 1
channel ch4: restore complete, elapsed time: 00:04:45
channel ch4: starting datafile backup set restore
channel ch4: specifying datafile(s) to restore from backup set
channel ch4: restoring datafile 00026 to +DG_DATA/PCP/DATAFILE/data.282.1088784581
channel ch4: reading from backup piece tt3jlvh8_1_1
channel ch4: piece handle=tt3jlvh8_1_1 tag=PCP_ONL_MENSUAL
channel ch4: restored backup piece 1
channel ch4: restore complete, elapsed time: 00:04:35
channel ch4: starting datafile backup set restore
channel ch4: specifying datafile(s) to restore from backup set
channel ch4: restoring datafile 00027 to +DG_DATA/PCP/DATAFILE/data.283.1095258763
channel ch4: reading from backup piece tu3jlvho_1_1
channel ch4: piece handle=tu3jlvho_1_1 tag=PCP_ONL_MENSUAL
channel ch4: restored backup piece 1
channel ch4: restore complete, elapsed time: 00:04:46
channel ch4: starting datafile backup set restore
channel ch4: specifying datafile(s) to restore from backup set
channel ch4: restoring datafile 00028 to +DG_DATA/PCP/DATAFILE/ts_history.268
channel ch4: reading from backup piece tv3jlvir_1_1
channel ch4: piece handle=tv3jlvir_1_1 tag=PCP_ONL_MENSUAL
channel ch4: restored backup piece 1
channel ch4: restore complete, elapsed time: 00:05:55
channel ch4: starting datafile backup set restore
channel ch4: specifying datafile(s) to restore from backup set
channel ch4: restoring datafile 00029 to +DG_DATA/PCP/DATAFILE/data.285.1096277739
channel ch4: reading from backup piece u03jlvks_1_1
channel ch4: piece handle=u03jlvks_1_1 tag=PCP_ONL_MENSUAL
channel ch4: restored backup piece 1
channel ch4: restore complete, elapsed time: 00:06:05
channel ch4: starting datafile backup set restore
channel ch4: specifying datafile(s) to restore from backup set
channel ch4: restoring datafile 00030 to +DG_DATA/PCP/DATAFILE/data.286.1096967425
channel ch4: reading from backup piece u13jlvlv_1_1
channel ch4: piece handle=u13jlvlv_1_1 tag=PCP_ONL_MENSUAL
channel ch4: restored backup piece 1
channel ch4: restore complete, elapsed time: 00:04:46
channel ch4: starting datafile backup set restore
channel ch4: specifying datafile(s) to restore from backup set
channel ch4: restoring datafile 00031 to +DG_DATA/PCP/DATAFILE/data.287.1097571479
channel ch4: reading from backup piece u23jlvm6_1_1
channel ch4: piece handle=u23jlvm6_1_1 tag=PCP_ONL_MENSUAL
channel ch4: restored backup piece 1
channel ch4: restore complete, elapsed time: 00:03:35
channel ch4: starting datafile backup set restore
channel ch4: specifying datafile(s) to restore from backup set
channel ch4: restoring datafile 00032 to +DG_DATA/PCP/DATAFILE/data.288.1098435287
channel ch4: reading from backup piece u33jlvna_1_1
channel ch3: piece handle=tm3jlv8u_1_1 tag=PCP_ONL_MENSUAL
channel ch3: restored backup piece 1
channel ch3: restore complete, elapsed time: 01:02:24
channel ch3: starting datafile backup set restore
channel ch3: specifying datafile(s) to restore from backup set
channel ch3: restoring datafile 00033 to +DG_DATA/PCP/DATAFILE/data.289.1098867905
channel ch3: reading from backup piece u43jlvpb_1_1
channel ch3: piece handle=u43jlvpb_1_1 tag=PCP_ONL_MENSUAL
channel ch3: restored backup piece 1
channel ch3: restore complete, elapsed time: 00:05:35
channel ch3: starting datafile backup set restore
channel ch3: specifying datafile(s) to restore from backup set
channel ch3: restoring datafile 00034 to +DG_DATA/PCP/DATAFILE/data.290.1099383607
channel ch3: reading from backup piece u53jlvqe_1_1
channel ch3: piece handle=u53jlvqe_1_1 tag=PCP_ONL_MENSUAL
channel ch3: restored backup piece 1
channel ch3: restore complete, elapsed time: 00:04:45
channel ch3: starting datafile backup set restore
channel ch3: specifying datafile(s) to restore from backup set
channel ch3: restoring datafile 00035 to +DG_DATA/PCP/DATAFILE/data.291.1100164265
channel ch3: reading from backup piece u63jlvql_1_1
channel ch3: piece handle=u63jlvql_1_1 tag=PCP_ONL_MENSUAL
channel ch3: restored backup piece 1
channel ch3: restore complete, elapsed time: 00:04:36
channel ch3: starting datafile backup set restore
channel ch3: specifying datafile(s) to restore from backup set
channel ch3: restoring datafile 00036 to +DG_DATA/PCP/DATAFILE/data.292.1100164317
channel ch3: reading from backup piece u73jlvs2_1_1
channel ch3: piece handle=u73jlvs2_1_1 tag=PCP_ONL_MENSUAL
channel ch3: restored backup piece 1
channel ch3: restore complete, elapsed time: 00:04:55
channel ch3: starting datafile backup set restore
channel ch3: specifying datafile(s) to restore from backup set
channel ch3: restoring datafile 00037 to +DG_DATA/PCP/DATAFILE/data.293.1100767451
channel ch3: reading from backup piece u83jlvtp_1_1
channel ch3: piece handle=u83jlvtp_1_1 tag=PCP_ONL_MENSUAL
channel ch3: restored backup piece 1
channel ch3: restore complete, elapsed time: 00:02:55
channel ch3: starting datafile backup set restore
channel ch3: specifying datafile(s) to restore from backup set
channel ch3: restoring datafile 00038 to +DG_DATA/PCP/DATAFILE/data.294.1101286045
channel ch3: reading from backup piece u93jlvv7_1_1
channel ch3: piece handle=u93jlvv7_1_1 tag=PCP_ONL_MENSUAL
channel ch3: restored backup piece 1
channel ch3: restore complete, elapsed time: 00:04:35
channel ch3: starting datafile backup set restore
channel ch3: specifying datafile(s) to restore from backup set
channel ch3: restoring datafile 00039 to +DG_DATA/PCP/DATAFILE/data.295.1101716245
channel ch3: reading from backup piece ua3jlvv7_1_1
channel ch3: piece handle=ua3jlvv7_1_1 tag=PCP_ONL_MENSUAL
channel ch3: restored backup piece 1
channel ch3: restore complete, elapsed time: 00:04:36
channel ch3: starting datafile backup set restore
channel ch3: specifying datafile(s) to restore from backup set
channel ch3: restoring datafile 00040 to +DG_DATA/PCP/DATAFILE/data.296.1102496311
channel ch3: reading from backup piece ub3jm00k_1_1
channel ch4: piece handle=u33jlvna_1_1 tag=PCP_ONL_MENSUAL
channel ch4: restored backup piece 1
channel ch4: restore complete, elapsed time: 00:33:57
channel ch4: starting datafile backup set restore
channel ch4: specifying datafile(s) to restore from backup set
channel ch4: restoring datafile 00041 to +DG_DATA/PCP/DATAFILE/data.297.1102927647
channel ch4: reading from backup piece uc3jm02b_1_1
channel ch2: piece handle=t93jluqh_1_1 tag=PCP_ONL_MENSUAL
channel ch2: restored backup piece 1
channel ch2: restore complete, elapsed time: 03:03:10
channel ch2: starting datafile backup set restore
channel ch2: specifying datafile(s) to restore from backup set
channel ch2: restoring datafile 00042 to +DG_DATA/PCP/DATAFILE/data.298.1103274553
channel ch2: reading from backup piece ud3jm03o_1_1
channel ch2: piece handle=ud3jm03o_1_1 tag=PCP_ONL_MENSUAL
channel ch2: restored backup piece 1
channel ch2: restore complete, elapsed time: 00:12:35
channel ch2: starting datafile backup set restore
channel ch2: specifying datafile(s) to restore from backup set
channel ch2: restoring datafile 00043 to +DG_DATA/PCP/DATAFILE/data.299.1103878971
channel ch2: reading from backup piece ue3jm03o_1_1
channel ch2: piece handle=ue3jm03o_1_1 tag=PCP_ONL_MENSUAL
channel ch2: restored backup piece 1
channel ch2: restore complete, elapsed time: 00:06:46
channel ch2: starting datafile backup set restore
channel ch2: specifying datafile(s) to restore from backup set
channel ch2: restoring datafile 00044 to +DG_DATA/PCP/DATAFILE/data.300.1104220239
channel ch2: reading from backup piece uf3jm056_1_1
channel ch2: piece handle=uf3jm056_1_1 tag=PCP_ONL_MENSUAL
channel ch2: restored backup piece 1
channel ch2: restore complete, elapsed time: 00:03:55
channel ch2: starting datafile backup set restore
channel ch2: specifying datafile(s) to restore from backup set
channel ch2: restoring datafile 00045 to +DG_DATA/PCP/DATAFILE/data.301.1104678331
channel ch2: reading from backup piece ug3jm06t_1_1
channel ch2: piece handle=ug3jm06t_1_1 tag=PCP_ONL_MENSUAL
channel ch2: restored backup piece 1
channel ch2: restore complete, elapsed time: 00:06:15
channel ch2: starting datafile backup set restore
channel ch2: specifying datafile(s) to restore from backup set
channel ch2: restoring datafile 00046 to +DG_DATA/PCP/DATAFILE/data.302.1105432067
channel ch2: reading from backup piece uh3jm08a_1_1
channel ch2: piece handle=uh3jm08a_1_1 tag=PCP_ONL_MENSUAL
channel ch2: restored backup piece 1
channel ch2: restore complete, elapsed time: 00:05:16
channel ch2: starting datafile backup set restore
channel ch2: specifying datafile(s) to restore from backup set
channel ch2: restoring datafile 00047 to +DG_DATA/PCP/DATAFILE/data.303.1105693231
channel ch2: reading from backup piece ui3jm08a_1_1
channel ch2: piece handle=ui3jm08a_1_1 tag=PCP_ONL_MENSUAL
channel ch2: restored backup piece 1
channel ch2: restore complete, elapsed time: 00:04:45
channel ch2: starting datafile backup set restore
channel ch2: specifying datafile(s) to restore from backup set
channel ch2: restoring datafile 00048 to +DG_DATA/PCP/DATAFILE/data.304.1106122279
channel ch2: reading from backup piece uj3jm09n_1_1
channel ch2: piece handle=uj3jm09n_1_1 tag=PCP_ONL_MENSUAL
channel ch2: restored backup piece 1
channel ch2: restore complete, elapsed time: 00:03:45
channel ch2: starting datafile backup set restore
channel ch2: specifying datafile(s) to restore from backup set
channel ch2: restoring datafile 00049 to +DG_DATA/PCP/DATAFILE/data.305.1106564679
channel ch2: reading from backup piece uk3jm0be_1_1
channel ch2: piece handle=uk3jm0be_1_1 tag=PCP_ONL_MENSUAL
channel ch2: restored backup piece 1
channel ch2: restore complete, elapsed time: 00:02:55
channel ch2: starting datafile backup set restore
channel ch2: specifying datafile(s) to restore from backup set
channel ch2: restoring datafile 00050 to +DG_DATA/PCP/DATAFILE/data.306.1107342969
channel ch2: reading from backup piece ul3jm0cs_1_1
channel ch2: piece handle=ul3jm0cs_1_1 tag=PCP_ONL_MENSUAL
channel ch2: restored backup piece 1
channel ch2: restore complete, elapsed time: 00:05:56
channel ch2: starting datafile backup set restore
channel ch2: specifying datafile(s) to restore from backup set
channel ch2: restoring datafile 00051 to +DG_DATA/PCP/DATAFILE/data.307.1107503505
channel ch2: reading from backup piece um3jm0cs_1_1
channel ch4: piece handle=uc3jm02b_1_1 tag=PCP_ONL_MENSUAL
channel ch4: restored backup piece 1
channel ch4: restore complete, elapsed time: 00:55:48
channel ch4: starting datafile backup set restore
channel ch4: specifying datafile(s) to restore from backup set
channel ch4: restoring datafile 00052 to +DG_DATA/PCP/DATAFILE/undotbs1.308.1107514781
channel ch4: reading from backup piece un3jm0e9_1_1
channel ch4: piece handle=un3jm0e9_1_1 tag=PCP_ONL_MENSUAL
channel ch4: restored backup piece 1
channel ch4: restore complete, elapsed time: 00:07:25
channel ch4: starting datafile backup set restore
channel ch4: specifying datafile(s) to restore from backup set
channel ch4: restoring datafile 00053 to +DG_DATA/PCP/DATAFILE/data.309.1107935103
channel ch4: reading from backup piece uo3jm0g0_1_1
channel ch4: piece handle=uo3jm0g0_1_1 tag=PCP_ONL_MENSUAL
channel ch4: restored backup piece 1
channel ch4: restore complete, elapsed time: 00:05:35
channel ch4: starting datafile backup set restore
channel ch4: specifying datafile(s) to restore from backup set
channel ch4: restoring datafile 00055 to +DG_DATA/PCP/DATAFILE/data.311.1108454759
channel ch4: reading from backup piece uq3jm0hd_1_1
channel ch4: piece handle=uq3jm0hd_1_1 tag=PCP_ONL_MENSUAL
channel ch4: restored backup piece 1
channel ch4: restore complete, elapsed time: 00:02:55
channel ch4: starting datafile backup set restore
channel ch4: specifying datafile(s) to restore from backup set
channel ch4: restoring datafile 00054 to +DG_DATA/PCP/DATAFILE/undotbs1.310.1107943841
channel ch4: reading from backup piece up3jm0hd_1_1
channel ch4: piece handle=up3jm0hd_1_1 tag=PCP_ONL_MENSUAL
channel ch4: restored backup piece 1
channel ch4: restore complete, elapsed time: 00:05:45
channel ch4: starting datafile backup set restore
channel ch4: specifying datafile(s) to restore from backup set
channel ch4: restoring datafile 00056 to +DG_DATA/PCP/DATAFILE/undotbs1.312
channel ch4: reading from backup piece ur3jm0ir_1_1
channel ch4: piece handle=ur3jm0ir_1_1 tag=PCP_ONL_MENSUAL
channel ch4: restored backup piece 1
channel ch4: restore complete, elapsed time: 00:06:25
channel ch4: starting datafile backup set restore
channel ch4: specifying datafile(s) to restore from backup set
channel ch4: restoring datafile 00057 to +DG_DATA/PCP/DATAFILE/undotbs1.313
channel ch4: reading from backup piece us3jm0ki_1_1
channel ch4: piece handle=us3jm0ki_1_1 tag=PCP_ONL_MENSUAL
channel ch4: restored backup piece 1
channel ch4: restore complete, elapsed time: 00:05:26
channel ch4: starting datafile backup set restore
channel ch4: specifying datafile(s) to restore from backup set
channel ch4: restoring datafile 00058 to +DG_DATA/PCP/DATAFILE/data.314.1108887105
channel ch4: reading from backup piece ut3jm0lv_1_1
channel ch4: piece handle=ut3jm0lv_1_1 tag=PCP_ONL_MENSUAL
channel ch4: restored backup piece 1
channel ch4: restore complete, elapsed time: 00:03:55
channel ch4: starting datafile backup set restore
channel ch4: specifying datafile(s) to restore from backup set
channel ch4: restoring datafile 00060 to +DG_DATA/PCP/DATAFILE/undotbs1.314
channel ch4: reading from backup piece uu3jm0lv_1_1
channel ch4: piece handle=uu3jm0lv_1_1 tag=PCP_ONL_MENSUAL
channel ch4: restored backup piece 1
channel ch4: restore complete, elapsed time: 00:06:05
channel ch4: starting datafile backup set restore
channel ch4: specifying datafile(s) to restore from backup set
channel ch4: restoring datafile 00061 to +DG_DATA/PCP/DATAFILE/undotbs1.319
channel ch4: reading from backup piece uv3jm0nc_1_1
channel ch2: piece handle=um3jm0cs_1_1 tag=PCP_ONL_MENSUAL
channel ch2: restored backup piece 1
channel ch2: restore complete, elapsed time: 00:46:42
channel ch2: starting datafile backup set restore
channel ch2: specifying datafile(s) to restore from backup set
channel ch2: restoring datafile 00062 to +DG_DATA/PCP/DATAFILE/data.330
channel ch2: reading from backup piece v03jm0p3_1_1
channel ch2: piece handle=v03jm0p3_1_1 tag=PCP_ONL_MENSUAL
channel ch2: restored backup piece 1
channel ch2: restore complete, elapsed time: 00:07:46
channel ch2: starting datafile backup set restore
channel ch2: specifying datafile(s) to restore from backup set
channel ch2: restoring datafile 00064 to +DG_DATA/PCP/DATAFILE/ts_user.320.1110100313
channel ch2: reading from backup piece v23jm0qh_1_1
channel ch2: piece handle=v23jm0qh_1_1 tag=PCP_ONL_MENSUAL
channel ch2: restored backup piece 1
channel ch2: restore complete, elapsed time: 00:04:35
channel ch2: starting datafile backup set restore
channel ch2: specifying datafile(s) to restore from backup set
channel ch2: restoring datafile 00063 to +DG_DATA/PCP/DATAFILE/data.
channel ch2: reading from backup piece v13jm0qh_1_1
channel ch2: piece handle=v13jm0qh_1_1 tag=PCP_ONL_MENSUAL
channel ch2: restored backup piece 1
channel ch2: restore complete, elapsed time: 00:05:25
channel ch2: starting datafile backup set restore
channel ch2: specifying datafile(s) to restore from backup set
channel ch2: restoring datafile 00065 to +DG_DATA/PCP/DATAFILE/data.321.1110258161
channel ch2: reading from backup piece v33jm0ru_1_1
channel ch2: piece handle=v33jm0ru_1_1 tag=PCP_ONL_MENSUAL
channel ch2: restored backup piece 1
channel ch2: restore complete, elapsed time: 00:05:36
channel ch2: starting datafile backup set restore
channel ch2: specifying datafile(s) to restore from backup set
channel ch2: restoring datafile 00066 to +DG_DATA/PCP/DATAFILE/undotbs1.320
channel ch2: reading from backup piece v43jm0tl_1_1
channel ch2: piece handle=v43jm0tl_1_1 tag=PCP_ONL_MENSUAL
channel ch2: restored backup piece 1
channel ch2: restore complete, elapsed time: 00:05:45
channel ch2: starting datafile backup set restore
channel ch2: specifying datafile(s) to restore from backup set
channel ch2: restoring datafile 00067 to +DG_DATA/PCP/DATAFILE/undotbs1.321
channel ch2: reading from backup piece v53jm0uo_1_1
channel ch2: piece handle=v53jm0uo_1_1 tag=PCP_ONL_MENSUAL
channel ch2: restored backup piece 1
channel ch2: restore complete, elapsed time: 00:06:25
channel ch2: starting datafile backup set restore
channel ch2: specifying datafile(s) to restore from backup set
channel ch2: restoring datafile 00068 to +DG_DATA/PCP/DATAFILE/data.324.1110700045
channel ch2: reading from backup piece v63jm0v0_1_1
channel ch2: piece handle=v63jm0v0_1_1 tag=PCP_ONL_MENSUAL
channel ch2: restored backup piece 1
channel ch2: restore complete, elapsed time: 00:04:55
channel ch2: starting datafile backup set restore
channel ch2: specifying datafile(s) to restore from backup set
channel ch2: restoring datafile 00069 to +DG_DATA/PCP/DATAFILE/data.325.1111045311
channel ch2: reading from backup piece v73jm10d_1_1
channel ch2: piece handle=v73jm10d_1_1 tag=PCP_ONL_MENSUAL
channel ch2: restored backup piece 1
channel ch2: restore complete, elapsed time: 00:02:26
channel ch2: starting datafile backup set restore
channel ch2: specifying datafile(s) to restore from backup set
channel ch2: restoring datafile 00070 to +DG_DATA/PCP/DATAFILE/undotbs1.326.1111074151
channel ch2: reading from backup piece v83jm124_1_1
channel ch2: piece handle=v83jm124_1_1 tag=PCP_ONL_MENSUAL
channel ch2: restored backup piece 1
channel ch2: restore complete, elapsed time: 00:04:15
channel ch2: starting datafile backup set restore
channel ch2: specifying datafile(s) to restore from backup set
channel ch2: restoring datafile 00071 to +DG_DATA/PCP/DATAFILE/data.327.1111563815
channel ch2: reading from backup piece v93jm137_1_1
channel ch4: piece handle=uv3jm0nc_1_1 tag=PCP_ONL_MENSUAL
channel ch4: restored backup piece 1
channel ch4: restore complete, elapsed time: 00:50:38
channel ch4: starting datafile backup set restore
channel ch4: specifying datafile(s) to restore from backup set
channel ch4: restoring datafile 00072 to +DG_DATA/PCP/DATAFILE/data.328.1111564469
channel ch4: reading from backup piece va3jm13m_1_1
channel ch4: piece handle=va3jm13m_1_1 tag=PCP_ONL_MENSUAL
channel ch4: restored backup piece 1
channel ch4: restore complete, elapsed time: 00:05:05
channel ch4: starting datafile backup set restore
channel ch4: specifying datafile(s) to restore from backup set
channel ch4: restoring datafile 00073 to +DG_DATA/PCP/DATAFILE/undotbs1.325
channel ch4: reading from backup piece vb3jm153_1_1
channel ch4: piece handle=vb3jm153_1_1 tag=PCP_ONL_MENSUAL
channel ch4: restored backup piece 1
channel ch4: restore complete, elapsed time: 00:03:55
channel ch4: starting datafile backup set restore
channel ch4: specifying datafile(s) to restore from backup set
channel ch4: restoring datafile 00074 to +DG_DATA/PCP/DATAFILE/data.330.1112434643
channel ch4: reading from backup piece vc3jm16r_1_1
channel ch4: piece handle=vc3jm16r_1_1 tag=PCP_ONL_MENSUAL
channel ch4: restored backup piece 1
channel ch4: restore complete, elapsed time: 00:05:05
channel ch4: starting datafile backup set restore
channel ch4: specifying datafile(s) to restore from backup set
channel ch4: restoring datafile 00075 to +DG_DATA/PCP/DATAFILE/data.331
channel ch4: reading from backup piece vd3jm17u_1_1
channel ch4: piece handle=vd3jm17u_1_1 tag=PCP_ONL_MENSUAL
channel ch4: restored backup piece 1
channel ch4: restore complete, elapsed time: 00:04:05
channel ch4: starting datafile backup set restore
channel ch4: specifying datafile(s) to restore from backup set
channel ch4: restoring datafile 00076 to +DG_DATA/PCP/DATAFILE/undotbs1.323
channel ch4: reading from backup piece ve3jm18d_1_1
channel ch4: piece handle=ve3jm18d_1_1 tag=PCP_ONL_MENSUAL
channel ch4: restored backup piece 1
channel ch4: restore complete, elapsed time: 00:04:35
channel ch4: starting datafile backup set restore
channel ch4: specifying datafile(s) to restore from backup set
channel ch4: restoring datafile 00077 to +DG_DATA/PCP/DATAFILE/data.333.1113377889
channel ch4: reading from backup piece vf3jm19q_1_1
channel ch4: piece handle=vf3jm19q_1_1 tag=PCP_ONL_MENSUAL
channel ch4: restored backup piece 1
channel ch4: restore complete, elapsed time: 00:04:35
channel ch4: starting datafile backup set restore
channel ch4: specifying datafile(s) to restore from backup set
channel ch4: restoring datafile 00078 to +DG_DATA/PCP/DATAFILE/data.339
channel ch4: reading from backup piece vg3jm1bh_1_1
channel ch4: piece handle=vg3jm1bh_1_1 tag=PCP_ONL_MENSUAL
channel ch4: restored backup piece 1
channel ch4: restore complete, elapsed time: 00:04:35
channel ch4: starting datafile backup set restore
channel ch4: specifying datafile(s) to restore from backup set
channel ch4: restoring datafile 00079 to +DG_DATA/PCP/DATAFILE/data.335.1114156369
channel ch4: reading from backup piece vh3jm1ck_1_1
channel ch2: piece handle=v93jm137_1_1 tag=PCP_ONL_MENSUAL
channel ch2: restored backup piece 1
channel ch2: restore complete, elapsed time: 00:35:07
channel ch2: starting datafile backup set restore
channel ch2: specifying datafile(s) to restore from backup set
channel ch2: restoring datafile 00080 to +DG_DATA/PCP/DATAFILE/data.336.1114156427
channel ch2: reading from backup piece vi3jm1d4_1_1
channel ch2: piece handle=vi3jm1d4_1_1 tag=PCP_ONL_MENSUAL
channel ch2: restored backup piece 1
channel ch2: restore complete, elapsed time: 00:08:45
channel ch2: starting datafile backup set restore
channel ch2: specifying datafile(s) to restore from backup set
channel ch2: restoring datafile 00081 to +DG_DATA/PCP/DATAFILE/data.337.1114850783
channel ch2: reading from backup piece vj3jm1eh_1_1
channel ch2: piece handle=vj3jm1eh_1_1 tag=PCP_ONL_MENSUAL
channel ch2: restored backup piece 1
channel ch2: restore complete, elapsed time: 00:05:16
channel ch2: starting datafile backup set restore
channel ch2: specifying datafile(s) to restore from backup set
channel ch2: restoring datafile 00082 to +DG_DATA/PCP/DATAFILE/data.338.1115225981
channel ch2: reading from backup piece vk3jm1g8_1_1
channel ch2: piece handle=vk3jm1g8_1_1 tag=PCP_ONL_MENSUAL
channel ch2: restored backup piece 1
channel ch2: restore complete, elapsed time: 00:05:05
channel ch2: starting datafile backup set restore
channel ch2: specifying datafile(s) to restore from backup set
channel ch2: restoring datafile 00083 to +DG_DATA/PCP/DATAFILE/data.339.1115798337
channel ch2: reading from backup piece vl3jm1hb_1_1
channel ch2: piece handle=vl3jm1hb_1_1 tag=PCP_ONL_MENSUAL
channel ch2: restored backup piece 1
channel ch2: restore complete, elapsed time: 00:03:15
channel ch2: starting datafile backup set restore
channel ch2: specifying datafile(s) to restore from backup set
channel ch2: restoring datafile 00084 to +DG_DATA/PCP/DATAFILE/data.340.1115798435
channel ch2: reading from backup piece vm3jm1hq_1_1
channel ch2: piece handle=vm3jm1hq_1_1 tag=PCP_ONL_MENSUAL
channel ch2: restored backup piece 1
channel ch2: restore complete, elapsed time: 00:04:35
channel ch2: starting datafile backup set restore
channel ch2: specifying datafile(s) to restore from backup set
channel ch2: restoring datafile 00085 to +DG_DATA/PCP/DATAFILE/data.341.1116145995
channel ch2: reading from backup piece vn3jm1j7_1_1
channel ch2: piece handle=vn3jm1j7_1_1 tag=PCP_ONL_MENSUAL
channel ch2: restored backup piece 1
channel ch2: restore complete, elapsed time: 00:02:26
channel ch2: starting datafile backup set restore
channel ch2: specifying datafile(s) to restore from backup set
channel ch2: restoring datafile 00086 to +DG_DATA/PCP/DATAFILE/data.342.1116146117
channel ch2: reading from backup piece vo3jm1kv_1_1
channel ch4: piece handle=vh3jm1ck_1_1 tag=PCP_ONL_MENSUAL
channel ch4: restored backup piece 1
channel ch4: restore complete, elapsed time: 00:32:42
channel ch4: starting datafile backup set restore
channel ch4: specifying datafile(s) to restore from backup set
channel ch4: restoring datafile 00087 to +DG_DATA/PCP/DATAFILE/undotbs1.326
channel ch4: reading from backup piece vp3jm1m2_1_1
channel ch3: piece handle=ub3jm00k_1_1 tag=PCP_ONL_MENSUAL
channel ch3: restored backup piece 1
channel ch3: restore complete, elapsed time: 03:37:17
channel ch3: starting datafile backup set restore
channel ch3: specifying datafile(s) to restore from backup set
channel ch3: restoring datafile 00088 to +DG_DATA/PCP/DATAFILE/data.344.1117874425
channel ch3: reading from backup piece vq3jm1mh_1_1
channel ch3: piece handle=vq3jm1mh_1_1 tag=PCP_ONL_MENSUAL
channel ch3: restored backup piece 1
channel ch3: restore complete, elapsed time: 01:33:18
channel ch3: starting datafile backup set restore
channel ch3: specifying datafile(s) to restore from backup set
channel ch3: restoring datafile 00114 to +DG_DATA/PCP/DATAFILE/data.369.1125389401
channel ch3: reading from backup piece 0k3jm2la_1_1
channel ch4: piece handle=vp3jm1m2_1_1 tag=PCP_ONL_MENSUAL
channel ch4: restored backup piece 1
channel ch4: restore complete, elapsed time: 01:40:29
channel ch4: starting datafile backup set restore
channel ch4: specifying datafile(s) to restore from backup set
channel ch4: restoring datafile 00115 to +DG_DATA/PCP/DATAFILE/data.370.1125389451
channel ch4: reading from backup piece 0l3jm2lp_1_1
channel ch2: piece handle=vo3jm1kv_1_1 tag=PCP_ONL_MENSUAL
channel ch2: restored backup piece 1
channel ch2: restore complete, elapsed time: 01:43:59
channel ch2: starting datafile backup set restore
channel ch2: specifying datafile(s) to restore from backup set
channel ch2: restoring datafile 00116 to +DG_DATA/PCP/DATAFILE/data.371.1125389495
channel ch2: reading from backup piece 0m3jm2ms_1_1
channel ch2: piece handle=0m3jm2ms_1_1 tag=PCP_ONL_MENSUAL
channel ch2: restored backup piece 1
channel ch2: restore complete, elapsed time: 00:06:35
channel ch2: starting datafile backup set restore
channel ch2: specifying datafile(s) to restore from backup set
channel ch2: restoring datafile 00089 to +DG_DATA/PCP/DATAFILE/data.345.1117874531
channel ch2: reading from backup piece vr3jm1nu_1_1
channel ch4: piece handle=0l3jm2lp_1_1 tag=PCP_ONL_MENSUAL
channel ch4: restored backup piece 1
channel ch4: restore complete, elapsed time: 00:10:45
channel ch4: starting datafile backup set restore
channel ch4: specifying datafile(s) to restore from backup set
channel ch4: restoring datafile 00090 to +DG_DATA/PCP/DATAFILE/data.346.1117874643
channel ch4: reading from backup piece vs3jm1pl_1_1
channel ch3: piece handle=0k3jm2la_1_1 tag=PCP_ONL_MENSUAL
channel ch3: restored backup piece 1
channel ch3: restore complete, elapsed time: 00:17:36
channel ch3: starting datafile backup set restore
channel ch3: specifying datafile(s) to restore from backup set
channel ch3: restoring datafile 00091 to +DG_DATA/PCP/DATAFILE/data.347.1117874751
channel ch3: reading from backup piece vt3jm1qp_1_1
channel ch3: piece handle=vt3jm1qp_1_1 tag=PCP_ONL_MENSUAL
channel ch3: restored backup piece 1
channel ch3: restore complete, elapsed time: 00:09:36
channel ch3: starting datafile backup set restore
channel ch3: specifying datafile(s) to restore from backup set
channel ch3: restoring datafile 00117 to +DG_DATA/PCP/DATAFILE/data.372.1125389551
channel ch3: reading from backup piece 0n3jm2ms_1_1
channel ch4: piece handle=vs3jm1pl_1_1 tag=PCP_ONL_MENSUAL
channel ch4: restored backup piece 1
channel ch4: restore complete, elapsed time: 00:14:16
channel ch4: starting datafile backup set restore
channel ch4: specifying datafile(s) to restore from backup set
channel ch4: restoring datafile 00118 to +DG_DATA/PCP/DATAFILE/data.373.1125389593
channel ch4: reading from backup piece 0o3jm2ot_1_1
channel ch2: piece handle=vr3jm1nu_1_1 tag=PCP_ONL_MENSUAL
channel ch2: restored backup piece 1
channel ch2: restore complete, elapsed time: 00:18:26
channel ch2: starting datafile backup set restore
channel ch2: specifying datafile(s) to restore from backup set
channel ch2: restoring datafile 00119 to +DG_DATA/PCP/DATAFILE/data.374.1125389637
channel ch2: reading from backup piece 0p3jm2pd_1_1
channel ch2: piece handle=0p3jm2pd_1_1 tag=PCP_ONL_MENSUAL
channel ch2: restored backup piece 1
channel ch2: restore complete, elapsed time: 00:10:16
channel ch2: starting datafile backup set restore
channel ch2: specifying datafile(s) to restore from backup set
channel ch2: restoring datafile 00092 to +DG_DATA/PCP/DATAFILE/data.348.1118396409
channel ch2: reading from backup piece vu3jm1r8_1_1
channel ch4: piece handle=0o3jm2ot_1_1 tag=PCP_ONL_MENSUAL
channel ch4: restored backup piece 1
channel ch4: restore complete, elapsed time: 00:13:56
channel ch4: starting datafile backup set restore
channel ch4: specifying datafile(s) to restore from backup set
channel ch4: restoring datafile 00093 to +DG_DATA/PCP/DATAFILE/data.349.1118396455
channel ch4: reading from backup piece vv3jm1sl_1_1
channel ch3: piece handle=0n3jm2ms_1_1 tag=PCP_ONL_MENSUAL
channel ch3: restored backup piece 1
channel ch3: restore complete, elapsed time: 00:18:46
channel ch3: starting datafile backup set restore
channel ch3: specifying datafile(s) to restore from backup set
channel ch3: restoring datafile 00094 to +DG_DATA/PCP/DATAFILE/data.350.1118396559
channel ch3: reading from backup piece 003jm1uc_1_1
channel ch3: piece handle=003jm1uc_1_1 tag=PCP_ONL_MENSUAL
channel ch3: restored backup piece 1
channel ch3: restore complete, elapsed time: 12:32:32
channel ch3: starting datafile backup set restore
channel ch3: specifying datafile(s) to restore from backup set
channel ch3: restoring datafile 00122 to +DG_DATA/PCP/DATAFILE/data.377.1128260571
channel ch3: reading from backup piece 0q3jm2qg_1_1
channel ch4: piece handle=vv3jm1sl_1_1 tag=PCP_ONL_MENSUAL
channel ch4: restored backup piece 1
channel ch4: restore complete, elapsed time: 12:37:22
channel ch4: starting datafile backup set restore
channel ch4: specifying datafile(s) to restore from backup set
channel ch4: restoring datafile 00126 to +DG_MODEL/PCP/DATAFILE/ts_tx.260.1128869137
channel ch4: reading from backup piece 0r3jm2qg_1_1
channel ch2: piece handle=vu3jm1r8_1_1 tag=PCP_ONL_MENSUAL
channel ch2: restored backup piece 1
channel ch2: restore complete, elapsed time: 12:41:02
channel ch2: starting datafile backup set restore
channel ch2: specifying datafile(s) to restore from backup set
channel ch2: restoring datafile 00133 to +DG_DATA/PCP/DATAFILE/data.386.1137579511
channel ch2: reading from backup piece 0u3jm2th_1_1
channel ch3: piece handle=0q3jm2qg_1_1 tag=PCP_ONL_MENSUAL
channel ch3: restored backup piece 1
channel ch3: restore complete, elapsed time: 00:55:37
channel ch3: starting datafile backup set restore
channel ch3: specifying datafile(s) to restore from backup set
channel ch3: restoring datafile 00095 to +DG_DATA/PCP/DATAFILE/data.351.1118396601
channel ch3: reading from backup piece 013jm1vf_1_1
channel ch2: piece handle=0u3jm2th_1_1 tag=PCP_ONL_MENSUAL
channel ch2: restored backup piece 1
channel ch2: restore complete, elapsed time: 00:59:22
channel ch2: starting datafile backup set restore
channel ch2: specifying datafile(s) to restore from backup set
channel ch2: restoring datafile 00096 to +DG_DATA/PCP/DATAFILE/data.352.1119082313
channel ch2: reading from backup piece 023jm208_1_1
channel ch4: piece handle=0r3jm2qg_1_1 tag=PCP_ONL_MENSUAL
channel ch4: restored backup piece 1
channel ch4: restore complete, elapsed time: 01:02:23
channel ch4: starting datafile backup set restore
channel ch4: specifying datafile(s) to restore from backup set
channel ch4: restoring datafile 00097 to +DG_DATA/PCP/DATAFILE/data.353.1119082363
channel ch4: reading from backup piece 033jm21c_1_1
channel ch4: piece handle=033jm21c_1_1 tag=PCP_ONL_MENSUAL
channel ch4: restored backup piece 1
channel ch4: restore complete, elapsed time: 00:17:35
channel ch4: starting datafile backup set restore
channel ch4: specifying datafile(s) to restore from backup set
channel ch4: restoring datafile 00131 to +DG_MODEL/PCP/DATAFILE/ts_tx.261.1133946545
channel ch4: reading from backup piece 0s3jm2sh_1_1
channel ch2: piece handle=023jm208_1_1 tag=PCP_ONL_MENSUAL
channel ch2: restored backup piece 1
channel ch2: restore complete, elapsed time: 00:22:46
channel ch2: starting datafile backup set restore
channel ch2: specifying datafile(s) to restore from backup set
channel ch2: restoring datafile 00141 to +DG_DATA/PCP/DATAFILE/data.394.1145812719
channel ch2: reading from backup piece 0v3jm2ub_1_1
channel ch3: piece handle=013jm1vf_1_1 tag=PCP_ONL_MENSUAL
channel ch3: restored backup piece 1
channel ch3: restore complete, elapsed time: 00:33:07
channel ch3: starting datafile backup set restore
channel ch3: specifying datafile(s) to restore from backup set
channel ch3: restoring datafile 00132 to +DG_DATA/PCP/DATAFILE/ts_user.385.1133946671
channel ch3: reading from backup piece 0t3jm2ta_1_1
channel ch2: piece handle=0v3jm2ub_1_1 tag=PCP_ONL_MENSUAL
channel ch2: restored backup piece 1
channel ch2: restore complete, elapsed time: 00:07:40
channel ch2: starting datafile backup set restore
channel ch2: specifying datafile(s) to restore from backup set
channel ch2: restoring datafile 00098 to +DG_DATA/PCP/DATAFILE/undotbs1.328
channel ch2: reading from backup piece 043jm233_1_1
channel ch3: piece handle=0t3jm2ta_1_1 tag=PCP_ONL_MENSUAL
channel ch3: restored backup piece 1
channel ch3: restore complete, elapsed time: 00:09:20
channel ch3: starting datafile backup set restore
channel ch3: specifying datafile(s) to restore from backup set
channel ch3: restoring datafile 00099 to +DG_DATA/PCP/DATAFILE/data.355.1120721881
channel ch3: reading from backup piece 053jm246_1_1
channel ch4: piece handle=0s3jm2sh_1_1 tag=PCP_ONL_MENSUAL
channel ch4: restored backup piece 1
channel ch4: restore complete, elapsed time: 00:15:56
channel ch4: starting datafile backup set restore
channel ch4: specifying datafile(s) to restore from backup set
channel ch4: restoring datafile 00100 to +DG_DATA/PCP/DATAFILE/data.356.1120721907
channel ch4: reading from backup piece 063jm24v_1_1
channel ch4: piece handle=063jm24v_1_1 tag=PCP_ONL_MENSUAL
channel ch4: restored backup piece 1
channel ch4: restore complete, elapsed time: 00:09:06
channel ch4: starting datafile backup set restore
channel ch4: specifying datafile(s) to restore from backup set
channel ch4: restoring datafile 00164 to +DG_DATA/PCP/DATAFILE/ts_tx.431.1160044997
channel ch4: reading from backup piece 123jm309_1_1
channel ch3: piece handle=053jm246_1_1 tag=PCP_ONL_MENSUAL
channel ch3: restored backup piece 1
channel ch3: restore complete, elapsed time: 00:14:36
channel ch3: starting datafile backup set restore
channel ch3: specifying datafile(s) to restore from backup set
channel ch3: restoring datafile 00147 to +DG_DATA/PCP/DATAFILE/undotbs1.411.1150239831
channel ch3: reading from backup piece 103jm302_1_1
channel ch2: piece handle=043jm233_1_1 tag=PCP_ONL_MENSUAL
channel ch2: restored backup piece 1
channel ch2: restore complete, elapsed time: 00:19:46
channel ch2: starting datafile backup set restore
channel ch2: specifying datafile(s) to restore from backup set
channel ch2: restoring datafile 00148 to +DG_DATA/PCP/DATAFILE/undotbs1.412.1150244017
channel ch2: reading from backup piece 113jm302_1_1
channel ch4: piece handle=123jm309_1_1 tag=PCP_ONL_MENSUAL
channel ch4: restored backup piece 1
channel ch4: restore complete, elapsed time: 00:09:25
channel ch4: starting datafile backup set restore
channel ch4: specifying datafile(s) to restore from backup set
channel ch4: restoring datafile 00101 to +DG_DATA/PCP/DATAFILE/data.357.1120722003
channel ch4: reading from backup piece 073jm262_1_1
channel ch2: piece handle=113jm302_1_1 tag=PCP_ONL_MENSUAL
channel ch2: restored backup piece 1
channel ch2: restore complete, elapsed time: 00:06:41
channel ch2: starting datafile backup set restore
channel ch2: specifying datafile(s) to restore from backup set
channel ch2: restoring datafile 00102 to +DG_DATA/PCP/DATAFILE/data.358.1121416189
channel ch2: reading from backup piece 083jm27q_1_1
channel ch3: piece handle=103jm302_1_1 tag=PCP_ONL_MENSUAL
channel ch3: restored backup piece 1
channel ch3: restore complete, elapsed time: 00:10:31
channel ch3: starting datafile backup set restore
channel ch3: specifying datafile(s) to restore from backup set
channel ch3: restoring datafile 00103 to +DG_DATA/PCP/DATAFILE/data.359.1121416229
channel ch3: reading from backup piece 093jm28j_1_1
channel ch3: piece handle=093jm28j_1_1 tag=PCP_ONL_MENSUAL
channel ch3: restored backup piece 1
channel ch3: restore complete, elapsed time: 00:10:55
channel ch3: starting datafile backup set restore
channel ch3: specifying datafile(s) to restore from backup set
channel ch3: restoring datafile 00220 to +DG_DATA/PCP/DATAFILE/indx_pcp.488.1174665051
channel ch3: reading from backup piece 2f3jm4jo_1_1
channel ch2: piece handle=083jm27q_1_1 tag=PCP_ONL_MENSUAL
channel ch2: restored backup piece 1
channel ch2: restore complete, elapsed time: 00:15:45
channel ch2: starting datafile backup set restore
channel ch2: specifying datafile(s) to restore from backup set
channel ch2: restoring datafile 00221 to +DG_DATA/PCP/DATAFILE/indx_pcp.489.1174665087
channel ch2: reading from backup piece 2g3jm4kh_1_1
channel ch4: piece handle=073jm262_1_1 tag=PCP_ONL_MENSUAL
channel ch4: restored backup piece 1
channel ch4: restore complete, elapsed time: 00:20:47
channel ch4: starting datafile backup set restore
channel ch4: specifying datafile(s) to restore from backup set
channel ch4: restoring datafile 00222 to +DG_DATA/PCP/DATAFILE/indx_pcp.490.1174665375
channel ch4: reading from backup piece 2h3jm4l1_1_1
channel ch4: piece handle=2h3jm4l1_1_1 tag=PCP_ONL_MENSUAL
channel ch4: restored backup piece 1
channel ch4: restore complete, elapsed time: 00:08:35
channel ch4: starting datafile backup set restore
channel ch4: specifying datafile(s) to restore from backup set
channel ch4: restoring datafile 00104 to +DG_DATA/PCP/DATAFILE/data.360.1121416271
channel ch4: reading from backup piece 0a3jm29m_1_1
channel ch2: piece handle=2g3jm4kh_1_1 tag=PCP_ONL_MENSUAL
channel ch2: restored backup piece 1
channel ch2: restore complete, elapsed time: 00:13:16
channel ch2: starting datafile backup set restore
channel ch2: specifying datafile(s) to restore from backup set
channel ch2: restoring datafile 00105 to +DG_DATA/PCP/DATAFILE/data.361.1122973009
channel ch2: reading from backup piece 0b3jm2af_1_1
channel ch3: piece handle=2f3jm4jo_1_1 tag=PCP_ONL_MENSUAL
channel ch3: restored backup piece 1
channel ch3: restore complete, elapsed time: 00:18:06
channel ch3: starting datafile backup set restore
channel ch3: specifying datafile(s) to restore from backup set
channel ch3: restoring datafile 00106 to +DG_DATA/PCP/DATAFILE/data.362.1122973089
channel ch3: reading from backup piece 0c3jm2cg_1_1
channel ch3: piece handle=0c3jm2cg_1_1 tag=PCP_ONL_MENSUAL
channel ch3: restored backup piece 1
channel ch3: restore complete, elapsed time: 00:07:56
channel ch3: starting datafile backup set restore
channel ch3: specifying datafile(s) to restore from backup set
channel ch3: restoring datafile 00223 to +DG_DATA/PCP/DATAFILE/indx_pcp.491.1174665461
channel ch3: reading from backup piece 2i3jm4mo_1_1
channel ch2: piece handle=0b3jm2af_1_1 tag=PCP_ONL_MENSUAL
channel ch2: restored backup piece 1
channel ch2: restore complete, elapsed time: 00:13:06
channel ch2: starting datafile backup set restore
channel ch2: specifying datafile(s) to restore from backup set
channel ch2: restoring datafile 00224 to +DG_DATA/PCP/DATAFILE/indx_pcp.492.1174665651
channel ch2: reading from backup piece 2j3jm4o5_1_1
channel ch4: piece handle=0a3jm29m_1_1 tag=PCP_ONL_MENSUAL
channel ch4: restored backup piece 1
channel ch4: restore complete, elapsed time: 00:17:46
channel ch4: starting datafile backup set restore
channel ch4: specifying datafile(s) to restore from backup set
channel ch4: restoring datafile 00231 to +DG_DATA/PCP/DATAFILE/indx_pcp.499.1181992165
channel ch4: reading from backup piece 2p3jm4uj_1_1
channel ch2: piece handle=2j3jm4o5_1_1 tag=PCP_ONL_MENSUAL
channel ch2: restored backup piece 1
channel ch2: restore complete, elapsed time: 00:10:11
channel ch2: starting datafile backup set restore
channel ch2: specifying datafile(s) to restore from backup set
channel ch2: restoring datafile 00107 to +DG_DATA/PCP/DATAFILE/data.363.1122973193
channel ch2: reading from backup piece 0d3jm2d9_1_1
channel ch3: piece handle=2i3jm4mo_1_1 tag=PCP_ONL_MENSUAL
channel ch3: restored backup piece 1
channel ch3: restore complete, elapsed time: 00:16:41
channel ch3: starting datafile backup set restore
channel ch3: specifying datafile(s) to restore from backup set
channel ch3: restoring datafile 00108 to +DG_DATA/PCP/DATAFILE/data.364.1122973273
channel ch3: reading from backup piece 0e3jm2ed_1_1
channel ch4: piece handle=2p3jm4uj_1_1 tag=PCP_ONL_MENSUAL
channel ch4: restored backup piece 1
channel ch4: restore complete, elapsed time: 00:13:06
channel ch4: starting datafile backup set restore
channel ch4: specifying datafile(s) to restore from backup set
channel ch4: restoring datafile 00109 to +DG_DATA/PCP/DATAFILE/data.365.1122973425
channel ch4: reading from backup piece 0f3jm2es_1_1
channel ch4: piece handle=0f3jm2es_1_1 tag=PCP_ONL_MENSUAL
channel ch4: restored backup piece 1
channel ch4: restore complete, elapsed time: 00:06:05
channel ch4: starting datafile backup set restore
channel ch4: specifying datafile(s) to restore from backup set
channel ch4: restoring datafile 00232 to +DG_DATA/PCP/DATAFILE/indx_pcp.500.1181993023
channel ch4: reading from backup piece 2q3jm4uj_1_1
channel ch3: piece handle=0e3jm2ed_1_1 tag=PCP_ONL_MENSUAL
channel ch3: restored backup piece 1
channel ch3: restore complete, elapsed time: 00:10:25
channel ch3: starting datafile backup set restore
channel ch3: specifying datafile(s) to restore from backup set
channel ch3: restoring datafile 00234 to +DG_DATA/PCP/DATAFILE/indx_pcp.502.1185959747
channel ch3: reading from backup piece 2s3jm501_1_1
channel ch2: piece handle=0d3jm2d9_1_1 tag=PCP_ONL_MENSUAL
channel ch2: restored backup piece 1
channel ch2: restore complete, elapsed time: 00:15:16
channel ch2: starting datafile backup set restore
channel ch2: specifying datafile(s) to restore from backup set
channel ch2: restoring datafile 00235 to +DG_DATA/PCP/DATAFILE/logs_payhome.503.1186000691
channel ch2: reading from backup piece 2t3jm51e_1_1
channel ch2: piece handle=2t3jm51e_1_1 tag=PCP_ONL_MENSUAL
channel ch2: restored backup piece 1
channel ch2: restore complete, elapsed time: 00:05:25
channel ch2: starting datafile backup set restore
channel ch2: specifying datafile(s) to restore from backup set
channel ch2: restoring datafile 00110 to +DG_MODEL/PCP/DATAFILE/ts_tx.259.1124264933
channel ch2: reading from backup piece 0g3jm2h7_1_1
channel ch3: piece handle=2s3jm501_1_1 tag=PCP_ONL_MENSUAL
channel ch3: restored backup piece 1
channel ch3: restore complete, elapsed time: 00:08:05
channel ch3: starting datafile backup set restore
channel ch3: specifying datafile(s) to restore from backup set
channel ch3: restoring datafile 00111 to +DG_DATA/PCP/DATAFILE/data.366.1124464671
channel ch3: reading from backup piece 0h3jm2hm_1_1
channel ch4: piece handle=2q3jm4uj_1_1 tag=PCP_ONL_MENSUAL
channel ch4: restored backup piece 1
channel ch4: restore complete, elapsed time: 00:11:46
channel ch4: starting datafile backup set restore
channel ch4: specifying datafile(s) to restore from backup set
channel ch4: restoring datafile 00112 to +DG_DATA/PCP/DATAFILE/data.367.1124464707
channel ch4: reading from backup piece 0i3jm2ip_1_1
channel ch4: piece handle=0i3jm2ip_1_1 tag=PCP_ONL_MENSUAL
channel ch4: restored backup piece 1
channel ch4: restore complete, elapsed time: 00:07:06
channel ch4: starting datafile backup set restore
channel ch4: specifying datafile(s) to restore from backup set
channel ch4: restoring datafile 00237 to +DG_DATA/PCP/DATAFILE/indx_pcp.505.1189864827
channel ch4: reading from backup piece 2u3jm51e_1_1
channel ch3: piece handle=0h3jm2hm_1_1 tag=PCP_ONL_MENSUAL
channel ch3: restored backup piece 1
channel ch3: restore complete, elapsed time: 00:10:26
channel ch3: starting datafile backup set restore
channel ch3: specifying datafile(s) to restore from backup set
channel ch3: restoring datafile 00233 to +DG_DATA/PCP/DATAFILE/indx_pcp.501.1181998467
channel ch3: reading from backup piece 2r3jm501_1_1
channel ch4: piece handle=2u3jm51e_1_1 tag=PCP_ONL_MENSUAL
channel ch4: restored backup piece 1
channel ch4: restore complete, elapsed time: 00:02:45
channel ch4: starting datafile backup set restore
channel ch4: specifying datafile(s) to restore from backup set
channel ch4: restoring datafile 00113 to +DG_DATA/PCP/DATAFILE/data.368.1125389355
channel ch4: reading from backup piece 0j3jm2j9_1_1
channel ch3: piece handle=2r3jm501_1_1 tag=PCP_ONL_MENSUAL
channel ch3: restored backup piece 1
channel ch3: restore complete, elapsed time: 00:04:55
channel ch3: starting datafile backup set restore
channel ch3: specifying datafile(s) to restore from backup set
channel ch3: restoring datafile 00170 to +DG_DATA/PCP/DATAFILE/indx_user.438.1163285681
channel ch3: reading from backup piece 143jm327_1_1
channel ch4: piece handle=0j3jm2j9_1_1 tag=PCP_ONL_MENSUAL
channel ch4: restored backup piece 1
channel ch4: restore complete, elapsed time: 00:05:10
channel ch4: starting datafile backup set restore
channel ch4: specifying datafile(s) to restore from backup set
channel ch4: restoring datafile 00238 to +DG_DATA/PCP/DATAFILE/indx_pcp.506.1189864869
channel ch4: reading from backup piece 2v3jm51t_1_1
channel ch2: piece handle=0g3jm2h7_1_1 tag=PCP_ONL_MENSUAL
channel ch2: restored backup piece 1
channel ch2: restore complete, elapsed time: 00:18:46
channel ch2: starting datafile backup set restore
channel ch2: specifying datafile(s) to restore from backup set
channel ch2: restoring datafile 00239 to +DG_DATA/PCP/DATAFILE/indx_pcp.507.1189864911
channel ch2: reading from backup piece 303jm52d_1_1
channel ch3: piece handle=143jm327_1_1 tag=PCP_ONL_MENSUAL
channel ch3: restored backup piece 1
channel ch3: restore complete, elapsed time: 00:03:05
channel ch3: starting datafile backup set restore
channel ch3: specifying datafile(s) to restore from backup set
channel ch3: restoring datafile 00127 to +DG_DATA/PCP/DATAFILE/ts_user.381.1128869253
channel ch3: restoring datafile 00154 to +DG_DATA/PCP/DATAFILE/data.419.1158293405
channel ch3: restoring datafile 00160 to +DG_DATA/PCP/DATAFILE/data.427.1160044337
channel ch3: reading from backup piece 343jm53h_1_1
channel ch2: piece handle=303jm52d_1_1 tag=PCP_ONL_MENSUAL
channel ch2: restored backup piece 1
channel ch2: restore complete, elapsed time: 00:01:51
channel ch2: starting datafile backup set restore
channel ch2: specifying datafile(s) to restore from backup set
channel ch2: restoring datafile 00169 to +DG_DATA/PCP/DATAFILE/indx_user.437.1163285629
channel ch2: reading from backup piece 133jm30g_1_1
channel ch4: piece handle=2v3jm51t_1_1 tag=PCP_ONL_MENSUAL
channel ch4: restored backup piece 1
channel ch4: restore complete, elapsed time: 00:04:21
channel ch4: starting datafile backup set restore
channel ch4: specifying datafile(s) to restore from backup set
channel ch4: restoring datafile 00171 to +DG_DATA/PCP/DATAFILE/indx_user.439.1163285687
channel ch4: reading from backup piece 153jm33v_1_1
channel ch3: piece handle=343jm53h_1_1 tag=PCP_ONL_MENSUAL
channel ch3: restored backup piece 1
channel ch3: restore complete, elapsed time: 00:04:45
channel ch3: starting datafile backup set restore
channel ch3: specifying datafile(s) to restore from backup set
channel ch3: restoring datafile 00172 to +DG_DATA/PCP/DATAFILE/indx_user.440.1163285775
channel ch3: reading from backup piece 163jm34o_1_1
channel ch3: piece handle=163jm34o_1_1 tag=PCP_ONL_MENSUAL
channel ch3: restored backup piece 1
channel ch3: restore complete, elapsed time: 00:03:25
channel ch3: starting datafile backup set restore
channel ch3: specifying datafile(s) to restore from backup set
channel ch3: restoring datafile 00120 to +DG_DATA/PCP/DATAFILE/ts_history.375.1125907389
channel ch3: restoring datafile 00149 to +DG_DATA/PCP/DATAFILE/data.3
channel ch3: reading from backup piece 353jm541_1_1
channel ch4: piece handle=153jm33v_1_1 tag=PCP_ONL_MENSUAL
channel ch4: restored backup piece 1
channel ch4: restore complete, elapsed time: 00:08:05
channel ch4: starting datafile backup set restore
channel ch4: specifying datafile(s) to restore from backup set
channel ch4: restoring datafile 00138 to +DG_DATA/PCP/DATAFILE/data.391.1143798935
channel ch4: restoring datafile 00155 to +DG_DATA/PCP/DATAFILE/ts_user.423.1158942569
channel ch4: reading from backup piece 3b3jm57q_1_1
channel ch2: piece handle=133jm30g_1_1 tag=PCP_ONL_MENSUAL
channel ch2: restored backup piece 1
channel ch2: restore complete, elapsed time: 00:10:35
channel ch2: starting datafile backup set restore
channel ch2: specifying datafile(s) to restore from backup set
channel ch2: restoring datafile 00137 to +DG_DATA/PCP/DATAFILE/data.390.1139736513
channel ch2: restoring datafile 00153 to +DG_DATA/PCP/DATAFILE/ts_user.418.1155902409
channel ch2: reading from backup piece 3a3jm57q_1_1
channel ch3: piece handle=353jm541_1_1 tag=PCP_ONL_MENSUAL
channel ch3: restored backup piece 1
channel ch3: restore complete, elapsed time: 00:04:06
channel ch3: starting datafile backup set restore
channel ch3: specifying datafile(s) to restore from backup set
channel ch3: restoring datafile 00174 to +DG_DATA/PCP/DATAFILE/indx_user.442.1163285915
channel ch3: reading from backup piece 183jm34o_1_1
channel ch3: piece handle=183jm34o_1_1 tag=PCP_ONL_MENSUAL
channel ch3: restored backup piece 1
channel ch3: restore complete, elapsed time: 00:03:55
channel ch3: starting datafile backup set restore
channel ch3: specifying datafile(s) to restore from backup set
channel ch3: restoring datafile 00059 to +DG_DATA/PCP/DATAFILE/ts_history.269
channel ch3: reading from backup piece 393jm570_1_1
channel ch4: piece handle=3b3jm57q_1_1 tag=PCP_ONL_MENSUAL
channel ch4: restored backup piece 1
channel ch4: restore complete, elapsed time: 00:13:41
channel ch4: starting datafile backup set restore
channel ch4: specifying datafile(s) to restore from backup set
channel ch4: restoring datafile 00173 to +DG_DATA/PCP/DATAFILE/indx_user.441.1163285847
channel ch4: reading from backup piece 173jm34o_1_1
channel ch2: piece handle=3a3jm57q_1_1 tag=PCP_ONL_MENSUAL
channel ch2: restored backup piece 1
channel ch2: restore complete, elapsed time: 00:14:20
channel ch2: starting datafile backup set restore
channel ch2: specifying datafile(s) to restore from backup set
channel ch2: restoring datafile 00175 to +DG_DATA/PCP/DATAFILE/indx_pcp.443.1163287423
channel ch2: reading from backup piece 193jm38b_1_1
channel ch3: piece handle=393jm570_1_1 tag=PCP_ONL_MENSUAL
channel ch3: restored backup piece 1
channel ch3: restore complete, elapsed time: 00:11:35
channel ch3: starting datafile backup set restore
channel ch3: specifying datafile(s) to restore from backup set
channel ch3: restoring datafile 00177 to +DG_DATA/PCP/DATAFILE/indx_pcp.445.1163289205
channel ch3: reading from backup piece 1a3jm39f_1_1
channel ch3: piece handle=1a3jm39f_1_1 tag=PCP_ONL_MENSUAL
channel ch3: restored backup piece 1
channel ch3: restore complete, elapsed time: 00:04:55
channel ch3: starting datafile backup set restore
channel ch3: specifying datafile(s) to restore from backup set
channel ch3: restoring datafile 00178 to +DG_DATA/PCP/DATAFILE/indx_pcp.446.1163289451
channel ch3: reading from backup piece 1b3jm39f_1_1
channel ch3: piece handle=1b3jm39f_1_1 tag=PCP_ONL_MENSUAL
channel ch3: restored backup piece 1
channel ch3: restore complete, elapsed time: 00:04:25
channel ch3: starting datafile backup set restore
channel ch3: specifying datafile(s) to restore from backup set
channel ch3: restoring datafile 00179 to +DG_DATA/PCP/DATAFILE/indx_pcp.447.1163289597
channel ch3: reading from backup piece 1c3jm39u_1_1
channel ch3: piece handle=1c3jm39u_1_1 tag=PCP_ONL_MENSUAL
channel ch3: restored backup piece 1
channel ch3: restore complete, elapsed time: 00:03:55
channel ch3: starting datafile backup set restore
channel ch3: specifying datafile(s) to restore from backup set
channel ch3: restoring datafile 00180 to +DG_DATA/PCP/DATAFILE/indx_pcp.448.1163290057
channel ch3: reading from backup piece 1d3jm3d7_1_1
channel ch3: piece handle=1d3jm3d7_1_1 tag=PCP_ONL_MENSUAL
channel ch3: restored backup piece 1
channel ch3: restore complete, elapsed time: 00:04:45
channel ch3: starting datafile backup set restore
channel ch3: specifying datafile(s) to restore from backup set
channel ch3: restoring datafile 00181 to +DG_DATA/PCP/DATAFILE/indx_pcp.449.1163290497
channel ch3: reading from backup piece 1e3jm3ea_1_1
channel ch3: piece handle=1e3jm3ea_1_1 tag=PCP_ONL_MENSUAL
channel ch3: restored backup piece 1
channel ch3: restore complete, elapsed time: 00:05:15
channel ch3: starting datafile backup set restore
channel ch3: specifying datafile(s) to restore from backup set
channel ch3: restoring datafile 00182 to +DG_DATA/PCP/DATAFILE/indx_pcp.450.1163290723
channel ch3: reading from backup piece 1f3jm3ea_1_1
channel ch3: piece handle=1f3jm3ea_1_1 tag=PCP_ONL_MENSUAL
channel ch3: restored backup piece 1
channel ch3: restore complete, elapsed time: 00:04:15
channel ch3: starting datafile backup set restore
channel ch3: specifying datafile(s) to restore from backup set
channel ch3: restoring datafile 00183 to +DG_DATA/PCP/DATAFILE/indx_pcp.451.1163290789
channel ch3: reading from backup piece 1g3jm3eq_1_1
channel ch3: piece handle=1g3jm3eq_1_1 tag=PCP_ONL_MENSUAL
channel ch3: restored backup piece 1
channel ch3: restore complete, elapsed time: 00:03:35
channel ch3: starting datafile backup set restore
channel ch3: specifying datafile(s) to restore from backup set
channel ch3: restoring datafile 00184 to +DG_DATA/PCP/DATAFILE/indx_pcp.452.1163290847
channel ch3: reading from backup piece 1h3jm3i3_1_1
channel ch3: piece handle=1h3jm3i3_1_1 tag=PCP_ONL_MENSUAL
channel ch3: restored backup piece 1
channel ch3: restore complete, elapsed time: 00:05:26
channel ch3: starting datafile backup set restore
channel ch3: specifying datafile(s) to restore from backup set
channel ch3: restoring datafile 00185 to +DG_DATA/PCP/DATAFILE/indx_pcp.453.1163290915
channel ch3: reading from backup piece 1i3jm3is_1_1
channel ch3: piece handle=1i3jm3is_1_1 tag=PCP_ONL_MENSUAL
channel ch3: restored backup piece 1
channel ch3: restore complete, elapsed time: 00:05:15
channel ch3: starting datafile backup set restore
channel ch3: specifying datafile(s) to restore from backup set
channel ch3: restoring datafile 00186 to +DG_DATA/PCP/DATAFILE/indx_pcp.454.1163981007
channel ch3: reading from backup piece 1j3jm3is_1_1
channel ch3: piece handle=1j3jm3is_1_1 tag=PCP_ONL_MENSUAL
channel ch3: restored backup piece 1
channel ch3: restore complete, elapsed time: 00:06:05
channel ch3: starting datafile backup set restore
channel ch3: specifying datafile(s) to restore from backup set
channel ch3: restoring datafile 00187 to +DG_DATA/PCP/DATAFILE/indx_pcp.455.1163983471
channel ch3: reading from backup piece 1k3jm3jb_1_1
channel ch3: piece handle=1k3jm3jb_1_1 tag=PCP_ONL_MENSUAL
channel ch3: restored backup piece 1
channel ch3: restore complete, elapsed time: 00:05:45
channel ch3: starting datafile backup set restore
channel ch3: specifying datafile(s) to restore from backup set
channel ch3: restoring datafile 00189 to +DG_DATA/PCP/DATAFILE/indx_pcp.457.1163983711
channel ch3: reading from backup piece 1m3jm3nc_1_1
channel ch3: piece handle=1m3jm3nc_1_1 tag=PCP_ONL_MENSUAL
channel ch3: restored backup piece 1
channel ch3: restore complete, elapsed time: 00:05:45
channel ch3: starting datafile backup set restore
channel ch3: specifying datafile(s) to restore from backup set
channel ch3: restoring datafile 00190 to +DG_DATA/PCP/DATAFILE/indx_pcp.458.1163983815
channel ch3: reading from backup piece 1n3jm3nd_1_1
channel ch3: piece handle=1n3jm3nd_1_1 tag=PCP_ONL_MENSUAL
channel ch3: restored backup piece 1
channel ch3: restore complete, elapsed time: 00:04:25
channel ch3: starting datafile backup set restore
channel ch3: specifying datafile(s) to restore from backup set
channel ch3: restoring datafile 00188 to +DG_DATA/PCP/DATAFILE/indx_pcp.456.1163983611
channel ch3: reading from backup piece 1l3jm3n8_1_1
channel ch2: piece handle=193jm38b_1_1 tag=PCP_ONL_MENSUAL
channel ch2: restored backup piece 1
channel ch2: restore complete, elapsed time: 01:05:37
channel ch2: starting datafile backup set restore
channel ch2: specifying datafile(s) to restore from backup set
channel ch2: restoring datafile 00191 to +DG_DATA/PCP/DATAFILE/indx_pcp.459.1164024447
channel ch2: reading from backup piece 1o3jm3ns_1_1
channel ch2: piece handle=1o3jm3ns_1_1 tag=PCP_ONL_MENSUAL
channel ch2: restored backup piece 1
channel ch2: restore complete, elapsed time: 00:07:25
channel ch2: starting datafile backup set restore
channel ch2: specifying datafile(s) to restore from backup set
channel ch2: restoring datafile 00192 to +DG_DATA/PCP/DATAFILE/indx_pcp.460.1164024539
channel ch2: reading from backup piece 1p3jm3rp_1_1
channel ch2: piece handle=1p3jm3rp_1_1 tag=PCP_ONL_MENSUAL
channel ch2: restored backup piece 1
channel ch2: restore complete, elapsed time: 00:05:15
channel ch2: starting datafile backup set restore
channel ch2: specifying datafile(s) to restore from backup set
channel ch2: restoring datafile 00193 to +DG_DATA/PCP/DATAFILE/indx_pcp.461.1164024599
channel ch2: reading from backup piece 1q3jm3rp_1_1
channel ch2: piece handle=1q3jm3rp_1_1 tag=PCP_ONL_MENSUAL
channel ch2: restored backup piece 1
channel ch2: restore complete, elapsed time: 00:05:35
channel ch2: starting datafile backup set restore
channel ch2: specifying datafile(s) to restore from backup set
channel ch2: restoring datafile 00194 to +DG_DATA/PCP/DATAFILE/indx_pcp.462.1164024659
channel ch2: reading from backup piece 1r3jm3s1_1_1
channel ch2: piece handle=1r3jm3s1_1_1 tag=PCP_ONL_MENSUAL
channel ch2: restored backup piece 1
channel ch2: restore complete, elapsed time: 00:06:05
channel ch2: starting datafile backup set restore
channel ch2: specifying datafile(s) to restore from backup set
channel ch2: restoring datafile 00195 to +DG_DATA/PCP/DATAFILE/indx_pcp.463.1164024757
channel ch2: reading from backup piece 1s3jm3sg_1_1
channel ch2: piece handle=1s3jm3sg_1_1 tag=PCP_ONL_MENSUAL
channel ch2: restored backup piece 1
channel ch2: restore complete, elapsed time: 00:03:36
channel ch2: starting datafile backup set restore
channel ch2: specifying datafile(s) to restore from backup set
channel ch2: restoring datafile 00196 to +DG_DATA/PCP/DATAFILE/indx_pcp.464.1164024857
channel ch2: reading from backup piece 1t3jm40d_1_1
channel ch2: piece handle=1t3jm40d_1_1 tag=PCP_ONL_MENSUAL
channel ch2: restored backup piece 1
channel ch2: restore complete, elapsed time: 00:04:45
channel ch2: starting datafile backup set restore
channel ch2: specifying datafile(s) to restore from backup set
channel ch2: restoring datafile 00197 to +DG_DATA/PCP/DATAFILE/indx_pcp.465.1164024919
channel ch2: reading from backup piece 1u3jm40d_1_1
channel ch2: piece handle=1u3jm40d_1_1 tag=PCP_ONL_MENSUAL
channel ch2: restored backup piece 1
channel ch2: restore complete, elapsed time: 00:05:25
channel ch2: starting datafile backup set restore
channel ch2: specifying datafile(s) to restore from backup set
channel ch2: restoring datafile 00198 to +DG_DATA/PCP/DATAFILE/indx_pcp.466.1164025019
channel ch2: reading from backup piece 1v3jm40s_1_1
channel ch2: piece handle=1v3jm40s_1_1 tag=PCP_ONL_MENSUAL
channel ch2: restored backup piece 1
channel ch2: restore complete, elapsed time: 00:04:45
channel ch2: starting datafile backup set restore
channel ch2: specifying datafile(s) to restore from backup set
channel ch2: restoring datafile 00199 to +DG_DATA/PCP/DATAFILE/indx_pcp.467.1164025263
channel ch2: reading from backup piece 203jm40v_1_1
channel ch2: piece handle=203jm40v_1_1 tag=PCP_ONL_MENSUAL
channel ch2: restored backup piece 1
channel ch2: restore complete, elapsed time: 00:05:26
channel ch2: starting datafile backup set restore
channel ch2: specifying datafile(s) to restore from backup set
channel ch2: restoring datafile 00202 to +DG_DATA/PCP/DATAFILE/indx_history.470.1164065099
channel ch2: reading from backup piece 233jm45a_1_1
channel ch2: piece handle=233jm45a_1_1 tag=PCP_ONL_MENSUAL
channel ch2: restored backup piece 1
channel ch2: restore complete, elapsed time: 00:04:05
channel ch2: starting datafile backup set restore
channel ch2: specifying datafile(s) to restore from backup set
channel ch2: restoring datafile 00201 to +DG_DATA/PCP/DATAFILE/indx_history.469.1164065047
channel ch2: reading from backup piece 223jm457_1_1
channel ch2: piece handle=223jm457_1_1 tag=PCP_ONL_MENSUAL
channel ch2: restored backup piece 1
channel ch2: restore complete, elapsed time: 00:04:35
channel ch2: starting datafile backup set restore
channel ch2: specifying datafile(s) to restore from backup set
channel ch2: restoring datafile 00200 to +DG_DATA/PCP/DATAFILE/indx_pcp.468.1164025495
channel ch2: reading from backup piece 213jm457_1_1
channel ch2: piece handle=213jm457_1_1 tag=PCP_ONL_MENSUAL
channel ch2: restored backup piece 1
channel ch2: restore complete, elapsed time: 00:05:05
channel ch2: starting datafile backup set restore
channel ch2: specifying datafile(s) to restore from backup set
channel ch2: restoring datafile 00205 to +DG_DATA/PCP/DATAFILE/undotbs1.473.1164125571
channel ch2: reading from backup piece 243jm45p_1_1
channel ch3: piece handle=1l3jm3n8_1_1 tag=PCP_ONL_MENSUAL
channel ch3: restored backup piece 1
channel ch3: restore complete, elapsed time: 01:03:02
channel ch3: starting datafile backup set restore
channel ch3: specifying datafile(s) to restore from backup set
channel ch3: restoring datafile 00206 to +DG_DATA/PCP/DATAFILE/indx_pcp.474.1164155929
channel ch3: reading from backup piece 253jm46s_1_1
channel ch3: piece handle=253jm46s_1_1 tag=PCP_ONL_MENSUAL
channel ch3: restored backup piece 1
channel ch3: restore complete, elapsed time: 00:06:35
channel ch3: starting datafile backup set restore
channel ch3: specifying datafile(s) to restore from backup set
channel ch3: restoring datafile 00207 to +DG_DATA/PCP/DATAFILE/indx_pcp.475.1164156039
channel ch3: reading from backup piece 263jm48u_1_1
channel ch3: piece handle=263jm48u_1_1 tag=PCP_ONL_MENSUAL
channel ch3: restored backup piece 1
channel ch3: restore complete, elapsed time: 00:04:25
channel ch3: starting datafile backup set restore
channel ch3: specifying datafile(s) to restore from backup set
channel ch3: restoring datafile 00209 to +DG_DATA/PCP/DATAFILE/indx_pcp.477.1164156169
channel ch3: reading from backup piece 283jm4ag_1_1
channel ch3: piece handle=283jm4ag_1_1 tag=PCP_ONL_MENSUAL
channel ch3: restored backup piece 1
channel ch3: restore complete, elapsed time: 00:03:35
channel ch3: starting datafile backup set restore
channel ch3: specifying datafile(s) to restore from backup set
channel ch3: restoring datafile 00210 to +DG_DATA/PCP/DATAFILE/indx_pcp.478.1164156287
channel ch3: reading from backup piece 293jm4bj_1_1
channel ch3: piece handle=293jm4bj_1_1 tag=PCP_ONL_MENSUAL
channel ch3: restored backup piece 1
channel ch3: restore complete, elapsed time: 00:03:06
channel ch3: starting datafile backup set restore
channel ch3: specifying datafile(s) to restore from backup set
channel ch3: restoring datafile 00212 to +DG_DATA/PCP/DATAFILE/indx_user.480.1164540067
channel ch3: reading from backup piece 2b3jm4fb_1_1
channel ch3: piece handle=2b3jm4fb_1_1 tag=PCP_ONL_MENSUAL
channel ch3: restored backup piece 1
channel ch3: restore complete, elapsed time: 00:03:35
channel ch3: starting datafile backup set restore
channel ch3: specifying datafile(s) to restore from backup set
channel ch3: restoring datafile 00211 to +DG_DATA/PCP/DATAFILE/indx_pcp.479.1164156397
channel ch3: reading from backup piece 2a3jm4dk_1_1
channel ch3: piece handle=2a3jm4dk_1_1 tag=PCP_ONL_MENSUAL
channel ch3: restored backup piece 1
channel ch3: restore complete, elapsed time: 00:02:55
channel ch3: starting datafile backup set restore
channel ch3: specifying datafile(s) to restore from backup set
channel ch3: restoring datafile 00208 to +DG_DATA/PCP/DATAFILE/indx_pcp.476.1164156093
channel ch3: reading from backup piece 273jm4a1_1_1
channel ch3: piece handle=273jm4a1_1_1 tag=PCP_ONL_MENSUAL
channel ch3: restored backup piece 1
channel ch3: restore complete, elapsed time: 00:05:15
channel ch3: starting datafile backup set restore
channel ch3: specifying datafile(s) to restore from backup set
channel ch3: restoring datafile 00217 to +DG_DATA/PCP/DATAFILE/indx_pcp.485.1173975569
channel ch3: reading from backup piece 2c3jm4gf_1_1
channel ch3: piece handle=2c3jm4gf_1_1 tag=PCP_ONL_MENSUAL
channel ch3: restored backup piece 1
channel ch3: restore complete, elapsed time: 00:04:05
channel ch3: starting datafile backup set restore
channel ch3: specifying datafile(s) to restore from backup set
channel ch3: restoring datafile 00218 to +DG_DATA/PCP/DATAFILE/indx_pcp.486.1174664969
channel ch3: reading from backup piece 2d3jm4gu_1_1
channel ch3: piece handle=2d3jm4gu_1_1 tag=PCP_ONL_MENSUAL
channel ch3: restored backup piece 1
channel ch3: restore complete, elapsed time: 00:04:35
channel ch3: starting datafile backup set restore
channel ch3: specifying datafile(s) to restore from backup set
channel ch3: restoring datafile 00219 to +DG_DATA/PCP/DATAFILE/indx_pcp.487.1174665015
channel ch3: reading from backup piece 2e3jm4ib_1_1
channel ch3: piece handle=2e3jm4ib_1_1 tag=PCP_ONL_MENSUAL
channel ch3: restored backup piece 1
channel ch3: restore complete, elapsed time: 00:05:05
channel ch3: starting datafile backup set restore
channel ch3: specifying datafile(s) to restore from backup set
channel ch3: restoring datafile 00226 to +DG_DATA/PCP/DATAFILE/indx_pcp.494.1181989177
channel ch3: reading from backup piece 2k3jm4ok_1_1
channel ch2: piece handle=243jm45p_1_1 tag=PCP_ONL_MENSUAL
channel ch2: restored backup piece 1
channel ch2: restore complete, elapsed time: 00:45:53
channel ch2: starting datafile backup set restore
channel ch2: specifying datafile(s) to restore from backup set
channel ch2: restoring datafile 00229 to +DG_DATA/PCP/DATAFILE/indx_pcp.497.1181989501
channel ch2: reading from backup piece 2n3jm4rf_1_1
channel ch2: piece handle=2n3jm4rf_1_1 tag=PCP_ONL_MENSUAL
channel ch2: restored backup piece 1
channel ch2: restore complete, elapsed time: 00:05:15
channel ch2: starting datafile backup set restore
channel ch2: specifying datafile(s) to restore from backup set
channel ch2: restoring datafile 00227 to +DG_DATA/PCP/DATAFILE/undotbs1.495.1181989235
channel ch2: reading from backup piece 2l3jm4pd_1_1
channel ch2: piece handle=2l3jm4pd_1_1 tag=PCP_ONL_MENSUAL
channel ch2: restored backup piece 1
channel ch2: restore complete, elapsed time: 00:03:16
channel ch2: starting datafile backup set restore
channel ch2: specifying datafile(s) to restore from backup set
channel ch2: restoring datafile 00230 to +DG_DATA/PCP/DATAFILE/indx_pcp.498.1181989653
channel ch2: reading from backup piece 2o3jm4t6_1_1
channel ch2: piece handle=2o3jm4t6_1_1 tag=PCP_ONL_MENSUAL
channel ch2: restored backup piece 1
channel ch2: restore complete, elapsed time: 00:07:05
channel ch2: starting datafile backup set restore
channel ch2: specifying datafile(s) to restore from backup set
channel ch2: restoring datafile 00228 to +DG_DATA/PCP/DATAFILE/undotbs1.496.1181989417
channel ch2: reading from backup piece 2m3jm4rf_1_1
channel ch2: piece handle=2m3jm4rf_1_1 tag=PCP_ONL_MENSUAL
channel ch2: restored backup piece 1
channel ch2: restore complete, elapsed time: 00:04:15
channel ch2: starting datafile backup set restore
channel ch2: specifying datafile(s) to restore from backup set
channel ch2: restoring datafile 00240 to +DG_DATA/PCP/DATAFILE/indx_pcp.508.1189864955
channel ch2: reading from backup piece 313jm52k_1_1
channel ch2: piece handle=313jm52k_1_1 tag=PCP_ONL_MENSUAL
channel ch2: restored backup piece 1
channel ch2: restore complete, elapsed time: 00:03:25
channel ch2: starting datafile backup set restore
channel ch2: specifying datafile(s) to restore from backup set
channel ch2: restoring datafile 00246 to +DG_DATA/PCP/DATAFILE/indx_pcp.513.1191164919
channel ch2: reading from backup piece 333jm532_1_1
channel ch2: piece handle=333jm532_1_1 tag=PCP_ONL_MENSUAL
channel ch2: restored backup piece 1
channel ch2: restore complete, elapsed time: 00:02:15
channel ch2: starting datafile backup set restore
channel ch2: specifying datafile(s) to restore from backup set
channel ch2: restoring datafile 00241 to +DG_DATA/PCP/DATAFILE/indx_pcp.509.1189865005
channel ch2: reading from backup piece 323jm52r_1_1
channel ch2: piece handle=323jm52r_1_1 tag=PCP_ONL_MENSUAL
channel ch2: restored backup piece 1
channel ch2: restore complete, elapsed time: 00:01:25
channel ch2: starting datafile backup set restore
channel ch2: specifying datafile(s) to restore from backup set
channel ch2: restoring datafile 00125 to +DG_DATA/PCP/DATAFILE/ts_history.380.1128869023
channel ch2: restoring datafile 00143 to +DG_DATA/PCP/DATAFILE/data.396.1148742389
channel ch2: restoring datafile 00159 to +DG_DATA/PCP/DATAFILE/data.426.1160044281
channel ch2: reading from backup piece 363jm541_1_1
channel ch2: piece handle=363jm541_1_1 tag=PCP_ONL_MENSUAL
channel ch2: restored backup piece 1
channel ch2: restore complete, elapsed time: 00:04:05
channel ch2: starting datafile backup set restore
channel ch2: specifying datafile(s) to restore from backup set
channel ch2: restoring datafile 00121 to +DG_DATA/PCP/DATAFILE/data.376.1128260533
channel ch2: restoring datafile 00150 to +DG_DATA/PCP/DATAFILE/data.415.1153218627
channel ch2: reading from backup piece 373jm541_1_1
channel ch2: piece handle=373jm541_1_1 tag=PCP_ONL_MENSUAL
channel ch2: restored backup piece 1
channel ch2: restore complete, elapsed time: 00:04:45
channel ch2: starting datafile backup set restore
channel ch2: specifying datafile(s) to restore from backup set
channel ch2: restoring datafile 00128 to +DG_DATA/PCP/DATAFILE/data.382.1128869387
channel ch2: restoring datafile 00158 to +DG_DATA/PCP/DATAFILE/data.425.1158942921
channel ch2: restoring datafile 00161 to +DG_DATA/PCP/DATAFILE/data.428.1160044411
channel ch2: reading from backup piece 383jm570_1_1
channel ch4: piece handle=173jm34o_1_1 tag=PCP_ONL_MENSUAL
channel ch4: restored backup piece 1
channel ch4: restore complete, elapsed time: 03:33:41
channel ch4: starting datafile backup set restore
channel ch4: specifying datafile(s) to restore from backup set
channel ch4: restoring datafile 00124 to +DG_DATA/PCP/DATAFILE/ts_user.379.1128846083
channel ch4: restoring datafile 00152 to +DG_DATA/PCP/DATAFILE/data.417.1154884935
channel ch4: reading from backup piece 3d3jm5ac_1_1
channel ch3: piece handle=2k3jm4ok_1_1 tag=PCP_ONL_MENSUAL
channel ch3: restored backup piece 1
channel ch3: restore complete, elapsed time: 00:40:13
channel ch3: starting datafile backup set restore
channel ch3: specifying datafile(s) to restore from backup set
channel ch3: restoring datafile 00139 to +DG_DATA/PCP/DATAFILE/data.392.1144865119
channel ch3: restoring datafile 00168 to +DG_DATA/PCP/DATAFILE/indx_tx.436.1163285107
channel ch3: reading from backup piece 3c3jm5a5_1_1
channel ch3: piece handle=3c3jm5a5_1_1 tag=PCP_ONL_MENSUAL
channel ch3: restored backup piece 1
channel ch3: restore complete, elapsed time: 17:15:22
channel ch3: starting datafile backup set restore
channel ch3: specifying datafile(s) to restore from backup set
channel ch3: restoring datafile 00123 to +DG_DATA/PCP/DATAFILE/data.378.1128260613
channel ch3: restoring datafile 00151 to +DG_DATA/PCP/DATAFILE/data.416.1154884741
channel ch3: reading from backup piece 3e3jm5ag_1_1
channel ch3: piece handle=3e3jm5ag_1_1 tag=PCP_ONL_MENSUAL
channel ch3: restored backup piece 1
channel ch3: restore complete, elapsed time: 00:05:45
channel ch3: starting datafile backup set restore
channel ch3: specifying datafile(s) to restore from backup set
channel ch3: restoring datafile 00129 to +DG_DATA/PCP/DATAFILE/data.383.1132917247
channel ch3: restoring datafile 00162 to +DG_DATA/PCP/DATAFILE/data.429.1160044751
channel ch3: restoring datafile 00163 to +DG_DATA/PCP/DATAFILE/data.430.1160044887
channel ch3: reading from backup piece 3g3jm5da_1_1
channel ch2: piece handle=383jm570_1_1 tag=PCP_ONL_MENSUAL
channel ch2: restored backup piece 1
channel ch2: restore complete, elapsed time: 17:24:43
channel ch2: starting datafile backup set restore
channel ch2: specifying datafile(s) to restore from backup set
channel ch2: restoring datafile 00130 to +DG_DATA/PCP/DATAFILE/data.384.1132917391
channel ch2: restoring datafile 00165 to +DG_DATA/PCP/DATAFILE/data.432.1160045087
channel ch2: restoring datafile 00166 to +DG_DATA/PCP/DATAFILE/data.433.1160045271
channel ch2: reading from backup piece 3f3jm5av_1_1
channel ch2: piece handle=3f3jm5av_1_1 tag=PCP_ONL_MENSUAL
channel ch2: restored backup piece 1
channel ch2: restore complete, elapsed time: 00:08:36
channel ch2: starting datafile backup set restore
channel ch2: specifying datafile(s) to restore from backup set
channel ch2: restoring datafile 00134 to +DG_DATA/PCP/DATAFILE/data.387.1138451569
channel ch2: restoring datafile 00144 to +DG_DATA/PCP/DATAFILE/data.397.1148743145
channel ch2: reading from backup piece 3h3jm5dp_1_1
channel ch2: piece handle=3h3jm5dp_1_1 tag=PCP_ONL_MENSUAL
channel ch2: restored backup piece 1
channel ch2: restore complete, elapsed time: 00:11:15
channel ch2: starting datafile backup set restore
channel ch2: specifying datafile(s) to restore from backup set
channel ch2: restoring datafile 00135 to +DG_DATA/PCP/DATAFILE/data.388.1138459077
channel ch2: restoring datafile 00145 to +DG_DATA/PCP/DATAFILE/data.398.1149073197
channel ch2: reading from backup piece 3i3jm5e8_1_1
channel ch4: piece handle=3d3jm5ac_1_1 tag=PCP_ONL_MENSUAL
channel ch4: restored backup piece 1
channel ch4: restore complete, elapsed time: 18:05:14
channel ch4: starting datafile backup set restore
channel ch4: specifying datafile(s) to restore from backup set
channel ch4: restoring datafile 00136 to +DG_DATA/PCP/DATAFILE/data.389.1138459813
channel ch4: restoring datafile 00146 to +DG_DATA/PCP/DATAFILE/data.399.1150214843
channel ch4: reading from backup piece 3j3jm5e9_1_1
channel ch3: piece handle=3g3jm5da_1_1 tag=PCP_ONL_MENSUAL
channel ch3: restored backup piece 1
channel ch3: restore complete, elapsed time: 00:44:07
channel ch3: starting datafile backup set restore
channel ch3: specifying datafile(s) to restore from backup set
channel ch3: restoring datafile 00167 to +DG_DATA/PCP/DATAFILE/indx_tx.435.1163285023
channel ch3: reading from backup piece 3k3jm5gk_1_1
channel ch3: piece handle=3k3jm5gk_1_1 tag=PCP_ONL_MENSUAL
channel ch3: restored backup piece 1
channel ch3: restore complete, elapsed time: 00:25:26
channel ch3: starting datafile backup set restore
channel ch3: specifying datafile(s) to restore from backup set
channel ch3: restoring datafile 00203 to +DG_DATA/PCP/DATAFILE/indx_history.471.1164065111
channel ch3: reading from backup piece 3l3jm5hd_1_1
channel ch4: piece handle=3j3jm5e9_1_1 tag=PCP_ONL_MENSUAL
channel ch4: restored backup piece 1
channel ch4: restore complete, elapsed time: 00:30:07
channel ch4: starting datafile backup set restore
channel ch4: specifying datafile(s) to restore from backup set
channel ch4: restoring datafile 00204 to +DG_DATA/PCP/DATAFILE/indx_history.472.1164065205
channel ch4: reading from backup piece 3m3jm5hk_1_1
channel ch2: piece handle=3i3jm5e8_1_1 tag=PCP_ONL_MENSUAL
channel ch2: restored backup piece 1
channel ch2: restore complete, elapsed time: 00:53:38
channel ch2: starting datafile backup set restore
channel ch2: specifying datafile(s) to restore from backup set
channel ch2: restoring datafile 00225 to +DG_DATA/PCP/DATAFILE/sysaux.493.1178790319
channel ch2: reading from backup piece 3n3jm5hl_1_1
channel ch2: piece handle=3n3jm5hl_1_1 tag=PCP_ONL_MENSUAL
channel ch2: restored backup piece 1
channel ch2: restore complete, elapsed time: 00:23:16
channel ch2: starting datafile backup set restore
channel ch2: specifying datafile(s) to restore from backup set
channel ch2: restoring datafile 00242 to +DG_DATA/PCP/DATAFILE/undotbs1.510.1191162573
channel ch2: reading from backup piece 3p3jm5kg_1_1
channel ch4: piece handle=3m3jm5hk_1_1 tag=PCP_ONL_MENSUAL
channel ch4: restored backup piece 1
channel ch4: restore complete, elapsed time: 00:25:56
channel ch4: starting datafile backup set restore
channel ch4: specifying datafile(s) to restore from backup set
channel ch4: restoring datafile 00236 to +DG_DATA/PCP/DATAFILE/undotbs1.504.1189864695
channel ch4: reading from backup piece 3o3jm5j3_1_1
channel ch3: piece handle=3l3jm5hd_1_1 tag=PCP_ONL_MENSUAL
channel ch3: restored backup piece 1
channel ch3: restore complete, elapsed time: 00:30:57
channel ch3: starting datafile backup set restore
channel ch3: specifying datafile(s) to restore from backup set
channel ch3: restoring datafile 00243 to +DG_MODEL/PCP/DATAFILE/ts_tx.262.1191164239
channel ch3: reading from backup piece 3r3jm5ku_1_1
channel ch3: piece handle=3r3jm5ku_1_1 tag=PCP_ONL_MENSUAL
channel ch3: restored backup piece 1
channel ch3: restore complete, elapsed time: 01:01:57
channel ch3: starting datafile backup set restore
channel ch3: specifying datafile(s) to restore from backup set
channel ch3: restoring datafile 00244 to +DG_DATA/PCP/DATAFILE/indx_pcp.511.1191164661
channel ch3: reading from backup piece 3s3jm5l5_1_1
channel ch2: piece handle=3p3jm5kg_1_1 tag=PCP_ONL_MENSUAL
channel ch2: restored backup piece 1
channel ch2: restore complete, elapsed time: 01:07:22
channel ch2: starting datafile backup set restore
channel ch2: specifying datafile(s) to restore from backup set
channel ch2: restoring datafile 00245 to +DG_DATA/PCP/DATAFILE/indx_pcp.512.1191164811
channel ch2: reading from backup piece 3t3jm5lk_1_1
channel ch2: piece handle=3t3jm5lk_1_1 tag=PCP_ONL_MENSUAL
channel ch2: restored backup piece 1
channel ch2: restore complete, elapsed time: 00:06:06
channel ch2: starting datafile backup set restore
channel ch2: specifying datafile(s) to restore from backup set
channel ch2: restoring datafile 00247 to +DG_DATA/PCP/DATAFILE/indx_pcp.514.1191164961
channel ch2: reading from backup piece 3u3jm5ll_1_1
channel ch3: piece handle=3s3jm5l5_1_1 tag=PCP_ONL_MENSUAL
channel ch3: restored backup piece 1
channel ch3: restore complete, elapsed time: 00:09:26
channel ch3: starting datafile backup set restore
channel ch3: specifying datafile(s) to restore from backup set
channel ch3: restoring datafile 00140 to +DG_DATA/PCP/DATAFILE/data.393.1145634041
channel ch3: reading from backup piece 3q3jm5kn_1_1
channel ch2: piece handle=3u3jm5ll_1_1 tag=PCP_ONL_MENSUAL
channel ch2: restored backup piece 1
channel ch2: restore complete, elapsed time: 00:05:10
channel ch3: piece handle=3q3jm5kn_1_1 tag=PCP_ONL_MENSUAL
channel ch3: restored backup piece 1
channel ch3: restore complete, elapsed time: 00:05:35
channel ch4: piece handle=3o3jm5j3_1_1 tag=PCP_ONL_MENSUAL
channel ch4: restored backup piece 1
channel ch4: restore complete, elapsed time: 01:19:23

user interrupt received
Killed


RMAN> RUN {
    ALLOCATE CHANNEL ch1 D2> EVICE TYPE sbt_tape
    SEND 'SB3> T_PARMS=(NSR_SERVER=cpprwnetworkerp,NSR_STORAGE_NODE=plsnwk01,NSR_DATA_VOLUME_POOL=PCP_ONL_MENSUAL,NSR_CLIENT=sun2317p)';

 4> 5>    # Restauramos solo el datafile que contiene la pieza (File 4)
    RESTORE DATAFILE 4;

  6> 7> 8>   RELEASE CHANNEL ch1;
}
9>
allocated channel: ch1
channel ch1: SID=3764 device type=SBT_TAPE
channel ch1: NMDA Oracle v19.2.1.3

Starting restore at 23-APR-2026 16:37:45

new media label is "BO4860L9" for piece "t73jlulm_1_1"
channel ch1: starting datafile backup set restore
channel ch1: specifying datafile(s) to restore from backup set
channel ch1: restoring datafile 00004 to +DG_DATA/PCP/DATAFILE/undotbs1.258.1018885305
channel ch1: reading from backup piece t73jlulm_1_1



channel ch1: piece handle=t73jlulm_1_1 tag=PCP_ONL_MENSUAL
channel ch1: restored backup piece 1
channel ch1: restore complete, elapsed time: 00:14:15
Finished restore at 23-APR-2026 16:52:11

released channel: ch1



**********************************************************
RECOVER
**********************************************************

RMAN> RUN
{
    allocate channel ch1 d2> 3> evice type sbt_tape ;
    alloca4> te channel ch2 device type sbt_tape ;
    allocate channel ch3 d5> evice type sbt_tape ;
    alloca6> te channel ch4 device type sbt_tape ;
    SET UNTIL TIME "to_date('06-MAR-2025 15:46:07','dd-mm-7> yyyy hh24:mi:ss')";
        send 'SBT_P8> ARMS=(NSR_SERVER=cpprwnetworkerp,NSR_STORAGE_NODE=plsnwk01,NSR_DATA_VOLUME_POOL=PCP_ONL_MENSUAL,NSR_CLIENT=sun2317p)';
    RECOVER database;
    release channel9> 10>  ch1 ;
    release channel ch2 ;11>
    release channel ch3 ;
    r12> 13> elease channel ch4 ;
}14>

allocated channel: ch1
channel ch1: SID=3764 device type=SBT_TAPE
channel ch1: NMDA Oracle v19.2.1.3

allocated channel: ch2
channel ch2: SID=10343 device type=SBT_TAPE
channel ch2: NMDA Oracle v19.2.1.3

allocated channel: ch3
channel ch3: SID=11283 device type=SBT_TAPE
channel ch3: NMDA Oracle v19.2.1.3

allocated channel: ch4
channel ch4: SID=14105 device type=SBT_TAPE
channel ch4: NMDA Oracle v19.2.1.3

executing command: SET until clause

sent command to channel: ch1
sent command to channel: ch2
sent command to channel: ch3
sent command to channel: ch4

Starting recover at 23-APR-2026 16:55:06

starting media recovery

new media label is "BO4861L9" for piece "4b3jm5u4_1_1"
new media label is "BO4861L9" for piece "4f3jm5uu_1_1"
new media label is "BO4861L9" for piece "4e3jm5u5_1_1"
new media label is "BO4861L9" for piece "4g3jm5vn_1_1"
new media label is "BO4861L9" for piece "4h3jm5vq_1_1"
new media label is "BO4861L9" for piece "4j3jm5vt_1_1"
channel ch1: starting archived log restore to default destination
channel ch1: restoring archived log
archived log thread=1 sequence=89571
channel ch1: reading from backup piece 4b3jm5u4_1_1
channel ch2: starting archived log restore to default destination
channel ch2: restoring archived log
archived log thread=1 sequence=89572
channel ch2: reading from backup piece 4f3jm5uu_1_1
channel ch3: starting archived log restore to default destination
channel ch3: restoring archived log
archived log thread=1 sequence=89573
channel ch3: reading from backup piece 4e3jm5u5_1_1
channel ch4: starting archived log restore to default destination
channel ch4: restoring archived log
archived log thread=1 sequence=89574
channel ch4: reading from backup piece 4g3jm5vn_1_1
channel ch4: piece handle=4g3jm5vn_1_1 tag=PCP_ARCH_MEN
channel ch4: restored backup piece 1
channel ch4: restore complete, elapsed time: 00:05:05
channel ch4: starting archived log restore to default destination
channel ch4: restoring archived log
archived log thread=1 sequence=89575
channel ch4: reading from backup piece 4h3jm5vq_1_1
channel ch4: piece handle=4h3jm5vq_1_1 tag=PCP_ARCH_MEN
channel ch4: restored backup piece 1
channel ch4: restore complete, elapsed time: 00:02:25
channel ch4: starting archived log restore to default destination
channel ch4: restoring archived log
archived log thread=1 sequence=89576
channel ch4: reading from backup piece 4j3jm5vt_1_1
channel ch4: piece handle=4j3jm5vt_1_1 tag=PCP_ARCH_MEN
channel ch4: restored backup piece 1
channel ch4: restore complete, elapsed time: 00:04:05
channel ch2: piece handle=4f3jm5uu_1_1 tag=PCP_ARCH_MEN
channel ch2: restored backup piece 1
channel ch2: restore complete, elapsed time: 00:13:16
channel ch3: piece handle=4e3jm5u5_1_1 tag=PCP_ARCH_MEN
channel ch3: restored backup piece 1
channel ch3: restore complete, elapsed time: 00:16:47
channel ch1: piece handle=4b3jm5u4_1_1 tag=PCP_ARCH_MEN
channel ch1: restored backup piece 1
channel ch1: restore complete, elapsed time: 00:17:07
archived log file name=+FRA/PCP/ARCHIVELOG/2026_04_23/thread_1_seq_89571.262.1231348337 thread=1 sequence=89571
channel default: deleting archived log(s)
archived log file name=+FRA/PCP/ARCHIVELOG/2026_04_23/thread_1_seq_89571.262.1231348337 RECID=89582 STAMP=1231348355
archived log file name=+FRA/PCP/ARCHIVELOG/2026_04_23/thread_1_seq_89572.258.1231347629 thread=1 sequence=89572
channel default: deleting archived log(s)
archived log file name=+FRA/PCP/ARCHIVELOG/2026_04_23/thread_1_seq_89572.258.1231347629 RECID=89580 STAMP=1231348032
archived log file name=+FRA/PCP/ARCHIVELOG/2026_04_23/thread_1_seq_89573.261.1231348125 thread=1 sequence=89573
channel default: deleting archived log(s)
archived log file name=+FRA/PCP/ARCHIVELOG/2026_04_23/thread_1_seq_89573.261.1231348125 RECID=89581 STAMP=1231348142
archived log file name=+FRA/PCP/ARCHIVELOG/2026_04_23/thread_1_seq_89574.257.1231347489 thread=1 sequence=89574
channel default: deleting archived log(s)
archived log file name=+FRA/PCP/ARCHIVELOG/2026_04_23/thread_1_seq_89574.257.1231347489 RECID=89577 STAMP=1231347496
archived log file name=+FRA/PCP/ARCHIVELOG/2026_04_23/thread_1_seq_89575.259.1231347727 thread=1 sequence=89575
channel default: deleting archived log(s)
archived log file name=+FRA/PCP/ARCHIVELOG/2026_04_23/thread_1_seq_89575.259.1231347727 RECID=89578 STAMP=1231347733
archived log file name=+FRA/PCP/ARCHIVELOG/2026_04_23/thread_1_seq_89576.260.1231347985 thread=1 sequence=89576
channel default: deleting archived log(s)
archived log file name=+FRA/PCP/ARCHIVELOG/2026_04_23/thread_1_seq_89576.260.1231347985 RECID=89579 STAMP=1231347984
unable to find archived log
archived log thread=1 sequence=89577
released channel: ch1
released channel: ch2
released channel: ch3
released channel: ch4



**********************************************************
OPEN DATABASE
**********************************************************


RMAN> alter database open resetlogs;

Statement processed

**********************************************************
STATUS
**********************************************************
10:29:44 SYS@PCP> select status , instance_name from v$instance
10:29:46   2  /

STATUS       INSTANCE_NAME
------------ ----------------
OPEN         PCP
