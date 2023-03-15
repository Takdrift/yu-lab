---
title: "舟山孕妇产前随访高危因素SAS code"
date: 2019-04-10
lastmod: 2019-04-10
draft: false
slug: "high-risk-women-sas-code"  # 所生成网页的地址后缀，若未设置，会根据文件名生成地址
keywords: [舟山, 高危因素, SAS code]
tags: [舟山, 高危因素, SAS code]
categories: [Shao Bule]
author: "Shao Bule"
---

# 产前随访文本信息提取

以下为产前随访数据集（`fb_cqsffw`）中高危因素名称变量（`GWYSMC`）相关文本信息的提取过程

```SAS
**********************************************************************;
* Project         : risk factor extraction
*
* Program name    : [产前随访]高危因素.sas
*
* Author          : Shao
*
* Date created    : 20190319
*
* Purpose         : extract risk factor information (text) of pregnant women
*
* Revision History:
*
* Date        Author      Ref    Revision
*
**********************************************************************;

libname zs2 'C:\DATA\PhD\zhoushan2\SAS Dataset';
libname fb 'C:\DATA\PhD\zhoushan\fb';

data cq_;*==提取新的产前随访记录, 查找疾病信息;
  format  _djbh best18. ;
  set zs2.fb_cqsffw(keep=djbh dqyz  
                     gwysmc);*==dqyzts ssy szy tz gg fw xhdb ndb;
/*  d=scan(sfrq,1,'-');*==提取日;*/
/*  m=scan(sfrq,2,'-');*==提取月;*/
/*  y=scan(sfrq,3,'-');*==提取年;*/
/*  y=cats(20,y);*/
/*  m=compress(m,'1234567890','k');*==将月中的‘月‘字去除;*/
/*  date_sf=mdy(m,d,y);*==mdy函数转换日期;*/
  _djbh=djbh+0;
/*  _sfcs=sfcs+0;*/
/*  drop m d y sfrq djbh sfcs;*/
  drop djbh;
  rename _djbh=djbh;
run;

data _cq;*==提取老的产前随访记录, 查找疾病信息;
  set fb.fb_cqsffw(keep=djbh dqyz  
                     gwysmc);*==dqyzts ssy szy tz gg fw xhdb ndb;
/*  date_sf=input(scan(sfrq,1,''),yymmdd10.);*==提取并转换日期;*/
/*  format date_sf yymmdd10.;*/
/*  drop sfrq;*/
run;

data cq;*==合并新旧产前随访数据;
  length gwysmc $176.;
  set _cq cq_;
/*  risk_score=gwpff+0;*==高位评分;*/
run;

/*proc freq data=cq;table risk_score;run;*/
/**/
/*proc sort data=cq;by djbh;*/
/*proc sort data=gg;by djbh;*/
/**/
/*data want;*==终数据, 未挖掘文字;*/
/*  merge gg(in=a rename=(gwysmc=gwysmc_first)) cq;*/
/*  by djbh;*/
/*  if a;*/
/*  week_sf=floor((date_sf-lmp)/7);*==计算随访孕周;*/
/*run;*/

/*proc means data=want n nmiss;var date_sf;run;*==269个djbh没有合并上随访的信息;*/
/*proc freq data=want;table gwysmc/nopct nocol norow out=tmp;run;*/
/*options noquotelenmax;*/
data tmp;*==统计高危因素;
  set cq(keep=gwysmc djbh dqyz);
  dmA1=index(gwysmc,'A1级糖尿病')>0;
  dmA2=index(gwysmc,'A2级糖尿病')>0;
  ivf=index(gwysmc,'辅助生育')>0;
  amn=index(gwysmc,'羊水')>0;
  amn_hydr=index(gwysmc,'羊水过多')>0;
  amn_hyp=index(gwysmc,'羊水过少')>0;
  pos=index(gwysmc,'胎位异常')>0;
  abort=index(gwysmc,'≥3次引流产史')>0;
  preterm_his=index(gwysmc,'早产史')>0;
  thyroid=index(gwysmc,'甲状腺疾病')>0;
  thyroid_G=index(gwysmc,'甲状腺疾病病情稳定')>0;
  thyroid_B=index(gwysmc,'病情未稳定的甲状腺疾病')>0;
  umbilical=index(gwysmc,'脐带绕颈')>0;
  syphilis=index(gwysmc,'梅毒')>0;
  syphilis_G=index(gwysmc,'梅毒目前已规范治疗')>0;
  syphilis_B=index(gwysmc,'梅毒未经治疗')>0;
  plact_previa=index(gwysmc,'前置胎盘')>0;
  fgr=index(gwysmc,'胎儿生长受限')>0;
  scar_uterine=index(gwysmc,'疤痕子宫')>0;
  av_block=index(gwysmc,'房室传导阻滞')>0;
  anemia=index(gwysmc,'贫血')>0;
  pih=index(gwysmc,'妊娠期高血压')>0;
  twin=index(gwysmc,'双胎')>0;
  fetal_distress=index(gwysmc,'胎儿窘迫')>0;
  hypertension=index(gwysmc,'原发性高血压')>0;
  liver_impair=index(gwysmc,'肝损')>0;
  small_pelvic=index(gwysmc,'骨盆狭小')>0;
  c_sec=index(gwysmc,'剖宫产')>0;
  toxic_expose=index(gwysmc,'接触有害理化因素')>0;
  plt_low=index(gwysmc,'血小板减少')>0;
  cancer=index(gwysmc,'恶性肿瘤')>0;
  bile_acid=index(gwysmc,'胆汁酸')>0;
  plact_abruption=index(gwysmc,'胎盘早剥')>0;
  hysteromyo=index(gwysmc,'子宫肌瘤挖出术史')>0;
  mal_pelvic=index(gwysmc,'产道畸形')>0;
  mal_lung=index(gwysmc,'肺功能不全')>0;
  viral_hepa=index(gwysmc,'病毒性肝炎')>0;
  uteri_lax=index(gwysmc,'宫颈内口松弛')>0;
  ectopic=index(gwysmc,'异位妊娠')>0;
  kidney=index(gwysmc,'肾脏疾病')>0;
  still_birth=index(gwysmc,'死产')>0;
  fetal_death=index(gwysmc,'死胎')>0;
  heart_surg_his=index(gwysmc,'心脏手术史')>0;
  early_viral_infec=index(gwysmc,'孕早期病毒感染')>0;
  eclampsism=index(gwysmc,'子痫前期')>0;
  epilepsy=index(gwysmc,'癫痫')>0;
  severe_hepa=index(gwysmc,'重症肝炎')>0;
  length risk $500.;*==合并各种高危因素到risk, length=497;
  risk=cats('dmA1',dmA1,'|','dmA2',dmA2,'|','ivf',ivf,'|','amn',amn,'|','amn_hydr',amn_hydr,'|',
            'amn_hyp',amn_hyp,'|','pos',pos,'|','abort',abort,'|','preterm_his',preterm_his,'|',
            'thyroid',thyroid,'|','thyroid_G',thyroid_G,'|','thyroid_B',thyroid_B,'|',
            'umbilical',umbilical,'|','syphilis',syphilis,'|','syphilis_G',syphilis_G,'|',
            'syphilis_B',syphilis_B,'|','plact_previa',plact_previa,'|','fgr',fgr,'|',
            'scar_uterine',scar_uterine,'|','av_block',av_block,'|','anemia',anemia,'|','pih',pih,'|',
            'twin',twin,'|','fetal_distress',fetal_distress,'|','hypertension',hypertension,'|',
            'liver_impair',liver_impair,'|','small_pelvic',small_pelvic,'|','c_sec',c_sec,'|',
            'toxic_expose',toxic_expose,'|','plt_low',plt_low,'|','cancer',cancer,'|',
            'bile_acid',bile_acid,'|','plact_abruption',plact_abruption,'|','hysteromyo',hysteromyo,'|',
            'mal_pelvic',mal_pelvic,'|','mal_lung',mal_lung,'|','viral_hepa',viral_hepa,'|',
            'uteri_lax',uteri_lax,'|','ectopic',ectopic,'|','kidney',kidney,'|','still_birth',still_birth,'|',
            'fetal_death',fetal_death,'|','heart_surg_his',heart_surg_his,'|',
            'early_viral_infec',early_viral_infec,'|','eclampsism',eclampsism,'|','epilepsy',epilepsy,'|',
            'severe_hepa',severe_hepa
  );
run;

proc sort data=tmp nodupkey;by djbh dqyz;run;*==同一孕周的取前面一次;
proc transpose data=tmp out=tmp1(drop=_name_) prefix=risk_;*纵向数据转横向;
  where 0<=dqyz<=50;*==限定孕周;
  by djbh; *不转置变量;
  id dqyz ; *转置后的变量名，同一by下不能有重复的id，先剔重;
  var risk; *转置变量;
run;
/*proc freq data=tmp;table week_sf;where 0<=week_sf<=50;run;*/

data risk;*==转置后数据提取疾病信息;
  set tmp1;
  array risk [9:50] risk_9-risk_50;*==生成数组变量;
  *==初始化变量值;
  dmA1=0;dmA2=0;ivf=0;amn=0;amn_hydr=0;amn_hyp=0;pos=0;abort=0;preterm_his=0;thyroid=0;thyroid_G=0;
  thyroid_B=0;umbilical=0;syphilis=0;syphilis_G=0;syphilis_B=0;plact_previa=0;fgr=0;scar_uterine=0;
  av_block=0;anemia=0;pih=0;twin=0;fetal_distress=0;hypertension=0;liver_impair=0;small_pelvic=0;
  c_sec=0;toxic_expose=0;plt_low=0;cancer=0;bile_acid=0;plact_abruption=0;hysteromyo=0;mal_pelvic=0;
  mal_lung=0;viral_hepa=0;uteri_lax=0;ectopic=0;kidney=0;still_birth=0;fetal_death=0;heart_surg_his=0;
  early_viral_infec=0;eclampsism=0;epilepsy=0;severe_hepa=0;

  do i=9 to 50;*==循环叠加, 若有则+1;
    if index(risk[i],'dmA11')>0 then dmA1+1;
    if index(risk[i],'dmA21')>0 then dmA2+1;
    if index(risk[i],'ivf1')>0 then ivf+1;
    if index(risk[i],'amn1')>0 then amn+1;
    if index(risk[i],'amn_hydr1')>0 then amn_hydr+1;
    if index(risk[i],'amn_hyp1')>0 then amn_hyp+1;
    if index(risk[i],'pos1')>0 then pos+1;
    if index(risk[i],'abort1')>0 then abort+1;
    if index(risk[i],'preterm_his1')>0 then preterm_his+1;
    if index(risk[i],'thyroid1')>0 then thyroid+1;
    if index(risk[i],'thyroid_G1')>0 then thyroid_G+1;
    if index(risk[i],'thyroid_B1')>0 then thyroid_B+1;
    if index(risk[i],'umbilical1')>0 then umbilical+1;
    if index(risk[i],'syphilis1')>0 then syphilis+1;
    if index(risk[i],'syphilis_G1')>0 then syphilis_G+1;
    if index(risk[i],'syphilis_B1')>0 then syphilis_B+1;
    if index(risk[i],'plact_previa1')>0 then plact_previa+1;
    if index(risk[i],'fgr1')>0 then fgr+1;
    if index(risk[i],'scar_uterine1')>0 then scar_uterine+1;
    if index(risk[i],'av_block1')>0 then av_block+1;
    if index(risk[i],'anemia1')>0 then anemia+1;
    if index(risk[i],'pih1')>0 then pih+1;
    if index(risk[i],'twin1')>0 then twin+1;
    if index(risk[i],'fetal_distress1')>0 then fetal_distress+1;
    if index(risk[i],'hypertension1')>0 then hypertension+1;
    if index(risk[i],'liver_impair1')>0 then liver_impair+1;
    if index(risk[i],'small_pelvic1')>0 then small_pelvic+1;
    if index(risk[i],'c_sec1')>0 then c_sec+1;
    if index(risk[i],'toxic_expose1')>0 then toxic_expose+1;
    if index(risk[i],'plt_low1')>0 then plt_low+1;
    if index(risk[i],'cancer1')>0 then cancer+1;
    if index(risk[i],'bile_acid1')>0 then bile_acid+1;
    if index(risk[i],'plact_abruption1')>0 then plact_abruption+1;
    if index(risk[i],'hysteromyo1')>0 then hysteromyo+1;
    if index(risk[i],'mal_pelvic1')>0 then mal_pelvic+1;
    if index(risk[i],'mal_lung1')>0 then mal_lung+1;
    if index(risk[i],'viral_hepa1')>0 then viral_hepa+1;
    if index(risk[i],'uteri_lax1')>0 then uteri_lax+1;
    if index(risk[i],'ectopic1')>0 then ectopic+1;
    if index(risk[i],'kidney1')>0 then kidney+1;
    if index(risk[i],'still_birth1')>0 then still_birth+1;
    if index(risk[i],'fetal_death1')>0 then fetal_death+1;
    if index(risk[i],'heart_surg_his1')>0 then heart_surg_his+1;
    if index(risk[i],'early_viral_infec1')>0 then early_viral_infec+1;
    if index(risk[i],'eclampsism1')>0 then eclampsism+1;
    if index(risk[i],'epilepsy1')>0 then epilepsy+1;
    if index(risk[i],'severe_hepa1')>0 then severe_hepa+1;
  end;
  drop i;
  *==重新赋值变量为 0 1;
  dmA1=(dmA1 ne 0);dmA2=(dmA2 ne 0);ivf=(ivf ne 0);amn=(amn ne 0);amn_hydr=(amn_hydr ne 0);
  amn_hyp=(amn_hyp ne 0);pos=(pos ne 0);abort=(abort ne 0);preterm_his=(preterm_his ne 0);
  thyroid=(thyroid ne 0);thyroid_G=(thyroid_G ne 0);thyroid_B=(thyroid_B ne 0);umbilical=(umbilical ne 0);
  syphilis=(syphilis ne 0);syphilis_G=(syphilis_G ne 0);syphilis_B=(syphilis_B ne 0);
  plact_previa=(plact_previa ne 0);fgr=(fgr ne 0);scar_uterine=(scar_uterine ne 0);av_block=(av_block ne 0);
  anemia=(anemia ne 0);pih=(pih ne 0);twin=(twin ne 0);fetal_distress=(fetal_distress ne 0);
  hypertension=(hypertension ne 0);liver_impair=(liver_impair ne 0);small_pelvic=(small_pelvic ne 0);
  c_sec=(c_sec ne 0);toxic_expose=(toxic_expose ne 0);plt_low=(plt_low ne 0);cancer=(cancer ne 0);
  bile_acid=(bile_acid ne 0);plact_abruption=(plact_abruption ne 0);hysteromyo=(hysteromyo ne 0);
  mal_pelvic=(mal_pelvic ne 0);mal_lung=(mal_lung ne 0);viral_hepa=(viral_hepa ne 0);
  uteri_lax=(uteri_lax ne 0);ectopic=(ectopic ne 0);kidney=(kidney ne 0);still_birth=(still_birth ne 0);
  fetal_death=(fetal_death ne 0);heart_surg_his=(heart_surg_his ne 0);early_viral_infec=(early_viral_infec ne 0);
  eclampsism=(eclampsism ne 0);epilepsy=(epilepsy ne 0);severe_hepa=(severe_hepa ne 0);

  keep djbh dmA1 dmA2 ivf amn amn_hydr amn_hyp pos abort preterm_his thyroid thyroid_G thyroid_B umbilical 
       syphilis syphilis_G syphilis_B plact_previa fgr scar_uterine av_block anemia pih twin fetal_distress 
       hypertension liver_impair small_pelvic c_sec toxic_expose plt_low cancer bile_acid plact_abruption 
       hysteromyo mal_pelvic mal_lung viral_hepa uteri_lax ectopic kidney still_birth fetal_death 
       heart_surg_his early_viral_infec eclampsism epilepsy severe_hepa;
run;

*==导出高危因素名称数据集;
/*proc export data=risk*/
/*  outfile="C:\DATA\PhD\zhoushan\血样库\SAS Code\risk_name_zhoushan.csv"*/
/*  dbms=csv replace;*/
/*run;*/

ods output OneWayFreqs=freq(keep=table frequency percent);*==获取頻数;
proc freq data=risk;
  table 
  dmA1 dmA2 ivf amn amn_hydr amn_hyp pos abort preterm_his thyroid thyroid_G thyroid_B umbilical syphilis 
  syphilis_G syphilis_B plact_previa fgr scar_uterine av_block anemia pih twin fetal_distress hypertension 
  liver_impair small_pelvic c_sec toxic_expose plt_low cancer bile_acid plact_abruption hysteromyo mal_pelvic 
  mal_lung viral_hepa uteri_lax ectopic kidney still_birth fetal_death heart_surg_his early_viral_infec 
  eclampsism epilepsy severe_hepa
  ;
quit;

data freq1;*==获取各疾病信息的頻数;
  format riskname $30.;
  set freq;
  by table notsorted;
  if last.table;
  risk=scan(table,2,'');*=='Table';
  drop table;
  if risk='dmA1' then riskname='A1级糖尿病';
  if risk='dmA2' then riskname='A2级糖尿病';
  if risk='ivf' then riskname='辅助生育';
  if risk='amn' then riskname='羊水';
  if risk='amn_hydr' then riskname='羊水过多';
  if risk='amn_hyp' then riskname='羊水过少';
  if risk='pos' then riskname='胎位异常';
  if risk='abort' then riskname='≥3次引流产史';
  if risk='preterm_his' then riskname='早产史';
  if risk='thyroid' then riskname='甲状腺疾病';
  if risk='thyroid_G' then riskname='甲状腺疾病病情稳定';
  if risk='thyroid_B' then riskname='病情未稳定的甲状腺疾病';
  if risk='umbilical' then riskname='脐带绕颈';
  if risk='syphilis' then riskname='梅毒';
  if risk='syphilis_G' then riskname='梅毒目前已规范治疗';
  if risk='syphilis_B' then riskname='梅毒未经治疗';
  if risk='plact_previa' then riskname='前置胎盘';
  if risk='fgr' then riskname='胎儿生长受限';
  if risk='scar_uterine' then riskname='疤痕子宫';
  if risk='av_block' then riskname='房室传导阻滞';
  if risk='anemia' then riskname='贫血';
  if risk='pih' then riskname='妊娠期高血压';
  if risk='twin' then riskname='双胎';
  if risk='fetal_distress' then riskname='胎儿窘迫';
  if risk='hypertension' then riskname='原发性高血压';
  if risk='liver_impair' then riskname='肝损';
  if risk='small_pelvic' then riskname='骨盆狭小';
  if risk='c_sec' then riskname='剖宫产';
  if risk='toxic_expose' then riskname='接触有害理化因素';
  if risk='plt_low' then riskname='血小板减少';
  if risk='cancer' then riskname='恶性肿瘤';
  if risk='bile_acid' then riskname='胆汁酸';
  if risk='plact_abruption' then riskname='胎盘早剥';
  if risk='hysteromyo' then riskname='子宫肌瘤挖出术史';
  if risk='mal_pelvic' then riskname='产道畸形';
  if risk='mal_lung' then riskname='肺功能不全';
  if risk='viral_hepa' then riskname='病毒性肝炎';
  if risk='uteri_lax' then riskname='宫颈内口松弛';
  if risk='ectopic' then riskname='异位妊娠';
  if risk='kidney' then riskname='肾脏疾病';
  if risk='still_birth' then riskname='死产';
  if risk='fetal_death' then riskname='死胎';
  if risk='heart_surg_his' then riskname='心脏手术史';
  if risk='early_viral_infec' then riskname='孕早期病毒感染';
  if risk='eclampsism' then riskname='子痫前期';
  if risk='epilepsy' then riskname='癫痫';
  if risk='severe_hepa' then riskname='重症肝炎';
run;

*==导出数据到R中作图;
/*proc export data=freq1*/
/*  outfile="C:\DATA\PhD\zhoushan\血样库\SAS Code\R code\riskname_all_data.csv"*/
/*  dbms=csv replace;*/
/*run;*/

```

