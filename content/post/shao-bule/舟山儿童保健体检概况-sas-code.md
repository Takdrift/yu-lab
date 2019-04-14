---
title: "舟山儿童保健体检概况SAS code"
date: 2019-04-10
lastmod: 2019-04-10
draft: false
keywords: [舟山, 高危因素, SAS code]
tags: [舟山, 高危因素, SAS code]
categories: [邵, SAS code]
author: "Shao"
---

以下为儿童保健体检（`eb_bjtj`）数据概况展示的相关SAS code

```SAS
**********************************************************************;
* Project         : 新老儿童保健体检数据概况
*
* Program name    : [2016年后孕妇血样]基本情况-[儿童BJTJ].sas
*
* Author          : Shao
*
* Date created    : 20190327
*
* Purpose         : 合并新老BJTJ数据
*
* Revision History:
*
* Date        Author      Ref    Revision
*
**********************************************************************;
libname zs2 'C:\DATA\PhD\zhoushan2\SAS Dataset';
libname eb 'C:\DATA\PhD\zhoushan\eb';
libname gdm "C:\DATA\PhD\zhoushan\问卷";

/*start after line 68 w/ zs2.eb_bjtj_all*/
data _bj;*==老的儿童保健体检数据(原始导出的sas文件FYWSSDXS(服用维生素D详述)长度设置过短数据有截断，需设置为$50.重新导入);
  format date_child_sf yymmdd9.;
  set eb.eb_bjtj(
         keep=zxdaid sfrq nl nldw wyfs smwt hwhd tz tw tzpj sc 
         scpj sgtzpj tw yypj pf pfycxs szyc zysl yysl cys qcs xhdb 
         wmrcs nfl tjfscs qtyzjy rlyx sgsc dgs fywssd fywssdxs jxmrwy
  );
  date_child_sf=input(scan(sfrq, 1, ''), yymmdd10.);*==先转换sfrq;
run;

data bj_;*==新的儿童保健体检数据;
  format date_child_sf yymmdd9.;
  set zs2.eb_bjtj(
          keep=zxdaid sfrq nl nldw wyfs smwt hwhd tz tw tzpj sc 
          scpj sgtzpj tw yypj pf pfycxs szyc zysl yysl cys qcs xhdb 
          wmrcs nfl tjfscs qtyzjy rlyx sgsc dgs fywssd fywssdxs jxmrwy
  );
  _date=compress(sfrq, '月');*==先转换sfrq;
  date_child_sf=mdy(scan(_date,2,'-'),scan(_date,1,'-'),scan(_date,3,'-'));
  drop _date;
run;

/*利用宏对变量类型进行转换*/
%let vars=ZXDAID NLDW WYFS TZPJ SCPJ SGTZPJ PF RLYX SGSC JXMRWY;*==需要转换的变量名,变量之间用空格隔开;
%inc "C:\DATA\PhD\SAS\Marco\char2num.sas";
%char2num(dsname=bj_ ,dsout=bj__);*==定义数据集dsname, 输出数据集dsout;

/*%let vars=FYWSSD;*==需要转换的变量名,变量之间用空格隔开;*/
/*%inc "C:\DATA\PhD\SAS\Marco\char2num.sas";*/
/*%char2num(dsname=_bj ,dsout=__bj);*==定义数据集dsname, 输出数据集dsout;*/

data bj;*==合并新老保健体检数据;
  length HWHD $14. PFYCXS $66. WMRCS $10. NFL $15.  
         QTYZJY $255. DGS $10.;
  set _bj bj__;
run;

%inc "C:\DATA\PhD\zhoushan\血样库\SAS Code\[儿童保健体检]数据缺失情况.sas";
%missingVar(data=zs2.eb_bjtj_all, where=where varname ne 'SFRQ');*==修改成目标数据集;
*==导出数据到R中作图;
proc export data=freq
  outfile="C:\DATA\PhD\zhoushan\血样库\SAS Code\R code\bjtj_missing_var.csv"
  dbms=csv replace;
run;


*==上面的步骤生成终数据集 eb_bjtj_all;
data tj;*==新旧保健体检数据;
  set zs2.eb_bjtj_all;
run;

data _fe;*==老的妇儿保连接数据;
  set eb.fbeb2(drop=number);*==(rename=(number=twin));
run;

data fe_;*==新的妇儿保连接数据;
  set gdm.fez;
run;

data fe;*==合并新旧妇儿保连接数据, n=76822;
  set _fe fe_;
run;

proc sort data=fe;
by zxdaid;
proc sort data=tj;
by zxdaid;

data tj1;*==合并体检与妇儿连接数据, n=338795;
  merge fe(in=a) tj;
  by zxdaid;
  if a;
run;

*==查看合并后变量缺失的情况;
%missingVar(data=tj1, where=where varname ne 'SFRQ');*==data=目标数据, where=限定语句;
*==导出数据到R中作图;
proc export data=freq
  outfile="C:\DATA\PhD\zhoushan\血样库\SAS Code\R code\djbh_bjtj_missing_var.csv"
  dbms=csv replace;
run;

/*儿童专项档案数据合并*/
data _da;*==旧;
  format date_birth yymmdd9.;
  set eb.eb_zxda(keep=id etxm xb csrq csyzzs cstz csqk);
  date_birth=input(scan(csrq,1,''), yymmdd10.);
run;

data da_;*==新;
  format date_birth yymmdd9.;
  set zs2.eb_zxda(keep=id etxm xb csrq csyzzs cstz csqk);
  _date=compress(csrq, '月');*==先转换sfrq;
  date_birth=mdy(scan(_date,2,'-'),scan(_date,1,'-'),scan(_date,3,'-'));
  drop _date;
run;

/*利用宏对变量类型进行转换*/
%let vars=xb csqk ;*==需要转换的变量名,变量之间用空格隔开;
%inc "C:\DATA\PhD\SAS\Marco\char2num.sas";
%char2num(dsname=da_ ,dsout=da_);*==定义数据集dsname, 输出数据集dsout;

data da;*==合并新老数据;
  length etxm $15.;
  set _da da_;
  rename id=zxdaid;*==将专项档案里的ID rename;
run;

/*合并体检tj1与专项档案da数据*/
proc sort data=tj1 nodup;*==根据zxdaid剔重1026;
  by zxdaid;
run;
proc sort data=tj1 nodup;*==根据zxdaid和随访日期剔重24个;
  by zxdaid date_child_sf;
run;
proc sort data=tj1 nodupkey;*==在根据上述条件剔重18064人;
  by zxdaid date_child_sf;
run;

proc sort data=da nodupkey;*==剔除专项档案的重复记录, 2285 dup;
  by zxdaid etxm date_birth csyzzs;*==按ID、姓名、出生日期、出生孕周剔重;
run;

data tj2;
  merge tj1(in=a) da;
  by zxdaid;
  if a;

  *==计算随访日期、年龄;
  age_day=date_child_sf-date_birth;*==儿童随访时年龄;
  age_month=floor(age_day/30);
  age_year=floor(age_month/12);

  year_child_sf=year(date_child_sf);
  month_child_sf=month(date_child_sf);
run;

/*作图*/
  %let gpath='D:\SAS Graph';*定义图片导出路径;
  ods listing image_dpi=200 gpath=&gpath style=printer;*==style设置风格printer, journal, analysis;
/*  ods graphics /noborder height=350px;*==设置图片分辨率及名称;*/

  ods graphics /imagename='sf_year' noborder height=250px;*==设置图片分辨率及名称;
  Title1 f='Thorndale AMT/Bold' "随访年份分布";*==Title;
  proc sgplot data=tj2 noautolegend;
    where 2000<=year_child_sf<=2018;
    vbar year_child_sf/ stat=freq nooutline barwidth=0.5 transparency=0.5;*==分类变量分布;
    xaxis grid display=(noline noticks) label='年份' fitpolicy=rotate;*==values=(0 to 42 by 2);
    yaxis grid display=(noline noticks) label='样本数' ;*== values=(0 to 3600 by 400);
  run;

  ods graphics /imagename='sf_month' noborder height=250px;*==设置图片分辨率及名称;
  Title1 f='Thorndale AMT/Bold' "随访月份分布";*==Title;
  proc sgplot data=tj2 noautolegend;
    vbar month_child_sf/ stat=freq nooutline barwidth=0.5 transparency=0.5;*==分类变量分布;
    xaxis grid display=(noline ) label='月份' fitpolicy=thin;*====values=(0 to 42 by 2);
    yaxis grid display=(noline ) label='样本数' ;*==values=(0 to 5600 by 800);
  run;

  ods graphics /imagename='sf_age' noborder height=250px width=500px;*==设置图片分辨率及名称;
  Title1 f='Thorndale AMT/Bold' "随访月龄分布";*==Title;
  proc sgplot data=tj2 noautolegend;
    where 0<=age_month<=40;
    vbar age_month/ stat=freq nooutline barwidth=0.5 transparency=0.5;*==分类变量分布;
    xaxis grid display=(noline ) label='月龄' fitpolicy=thin;*====values=(0 to 42 by 2);
    yaxis grid display=(noline ) label='样本数' ;*==values=(0 to 5600 by 800);
  run;
/*作图*/

/*proc means data=tj2 n nmiss;*/
/*  var date_birth tz sc;*/
/*run;*/
/*proc freq data=tj2;*/
/*  table csqk xb;*/
/*run;*/

data tj3;*==提取随访日龄与 djbh zxdaid用于纵向合并, n=319681;
  set tj2(keep=zxdaid age_day tz);

  *==根据随访时的日龄定义随访年龄段;
  if 80<=age_day<=100 then month_sf_def=3;*==20 days range;
  if 170<=age_day<=190 then month_sf_def=6;
  if 230<=age_day<=250 then month_sf_def=8;
  if 260<=age_day<=280 then month_sf_def=9;
  if 350<=age_day<=380 then month_sf_def=12;*==30 days range;
  if 530<=age_day<=580 then month_sf_def=18;*==50 days range;
  if 720<=age_day<=770 then month_sf_def=24;
  if 890<=age_day<=940 then month_sf_def=30;
  if 1070<=age_day<=1130 then month_sf_def=36;*==60 days range;
run;

/*作图*/
  %let gpath='D:\SAS Graph';*定义图片导出路径;
  ods listing image_dpi=200 gpath=&gpath style=printer;*==style设置风格printer, journal, analysis;

  ods graphics /imagename='sf_age_def' noborder height=250px width=500px;*==设置图片分辨率及名称;
  Title1 f='Thorndale AMT/Bold' "定义的随访月龄分布";*==Title;
  proc sgplot data=tj3 noautolegend;
    vbar month_sf_def/ stat=freq nooutline datalabel barwidth=0.5 transparency=0.5;*==分类变量分布;
    xaxis grid display=(noline ) label='月龄' fitpolicy=thin;*====values=(0 to 42 by 2);
    yaxis grid display=(noline ) label='样本数' ;*==values=(0 to 5600 by 800);
  run;
/*作图*/

proc means data=tj3 n nmiss;*==82701 missing;
  var month_sf_def;
run;

proc sort data=tj3 nodup;*==无完全重复记录;
  by zxdaid month_sf_def;
run;
proc sort data=tj3 nodupkey;*==无同一人同一天检测的记录;
  by zxdaid age_day;
run;

proc sort data=tj3 nodupkey;*==总共45308条剔除,其中556人同一月龄多次随访记录,其余为定义月龄缺失;
  by zxdaid month_sf_def;
run;
proc transpose data=tj3 out=tj4(drop=_name_ _label_) prefix=wt_month_;*纵向数据转横向,n=5465,38个没有tri_vname,即没有问卷和首次随访信息的日期;
  by zxdaid; *不转置变量;
  id month_sf_def; *转置后的变量名，同一by下不能有重复的id，先剔重;
  var tz; *week_sample 转置变量;
run;

/*%let dataset=tj3(where=(month_sf_def ne .));*==数据集;%let byvar=zxdaid month_sf_def;*==排序变量;*/
/*proc sort data=&dataset nodupkey out=nodup dupout=dup(keep=&byvar);by &byvar;run;*==提取重复观测;*/
/*proc sort data=&dataset;by &byvar;*==原始数据排序;*/
/*data check;merge &dataset dup(in=a);by &byvar;if a;run;*==重复的观测;*/


proc sort data=tj2 nodupkey out=tj2_(keep=djbh zxdaid xb cstz csqk rename=(cstz=wt_month_0));
  by zxdaid;
run;

data tj5;*==将转至的数据合并上djbh;
  merge tj2_(in=a) tj4;
  by zxdaid;
  if a;

  *==查看纵向随访情况;
  combo_all=(wt_month_3 ne . and wt_month_6 ne . and (wt_month_8 ne . or wt_month_9 ne .) and wt_month_12 ne . and wt_month_18 ne . and wt_month_24 ne . and (wt_month_30 ne . or wt_month_36 ne .));*==wt_month_;
  combo_36912182436=(wt_month_3 ne . and wt_month_6 ne . and  wt_month_9 ne . and wt_month_12 ne . and wt_month_18 ne . and wt_month_24 ne . and wt_month_36 ne .);*==wt_month_;
  combo_3612182436=(wt_month_3 ne . and wt_month_6 ne . and wt_month_12 ne . and wt_month_18 ne . and wt_month_24 ne . and wt_month_36 ne .);*==wt_month_;
  combo_all_bwt=(combo_all=1 and wt_month_0 ne .);
  combo_36912182436_bwt=(combo_36912182436=1 and wt_month_0 ne .);
  combo_3612182436_bwt=(combo_3612182436=1 and wt_month_0 ne .);
run;

proc freq data=tj5;*==查看儿童各月龄纵向随访情况;
  table combo_all combo_36912182436 combo_3612182436
    combo_all_bwt combo_36912182436_bwt combo_3612182436_bwt
  /nopct norow nocol;*==/out=tmp;
run;
```

