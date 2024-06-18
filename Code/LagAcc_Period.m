clc
clear
[a,R]=geotiffread('E:\HBEY\lag&accumulation\KNDVI\2000_1_KNDVI.tif');  
info=geotiffinfo('E:\HBEY\lag&accumulation\KNDVI\2000_1_KNDVI.tif');
[m,n]=size(a);
path='E:\HBEY\lag&accumulation\Partial\';
outpath='E:\HBEY\lag&accumulation\Lag&Acc_Days\';
%% 气温
reT=zeros(m*n,10); 
da=importdata([path,'l0a0气温偏相关系数.tif']);reT(:,1)=reshape(da,m*n,1);
da=importdata([path,'l0a1气温偏相关系数.tif']);reT(:,2)=reshape(da,m*n,1);
da=importdata([path,'l0a2气温偏相关系数.tif']);reT(:,3)=reshape(da,m*n,1);
da=importdata([path,'l0a3气温偏相关系数.tif']);reT(:,4)=reshape(da,m*n,1);
da=importdata([path,'l1a0气温偏相关系数.tif']);reT(:,5)=reshape(da,m*n,1);
da=importdata([path,'l1a1气温偏相关系数.tif']);reT(:,6)=reshape(da,m*n,1);
da=importdata([path,'l1a2气温偏相关系数.tif']);reT(:,7)=reshape(da,m*n,1);
da=importdata([path,'l2a0气温偏相关系数.tif']);reT(:,8)=reshape(da,m*n,1);
da=importdata([path,'l2a1气温偏相关系数.tif']);reT(:,9)=reshape(da,m*n,1);
da=importdata([path,'l3a0气温偏相关系数.tif']);reT(:,10)=reshape(da,m*n,1);
reT=abs(reT);
%% 降水
reP=zeros(m*n,10); 
da=importdata([path,'l0a0降水偏相关系数.tif']);reP(:,1)=reshape(da,m*n,1);
da=importdata([path,'l0a1降水偏相关系数.tif']);reP(:,2)=reshape(da,m*n,1);
da=importdata([path,'l0a2降水偏相关系数.tif']);reP(:,3)=reshape(da,m*n,1);
da=importdata([path,'l0a3降水偏相关系数.tif']);reP(:,4)=reshape(da,m*n,1);
da=importdata([path,'l1a0降水偏相关系数.tif']);reP(:,5)=reshape(da,m*n,1);
da=importdata([path,'l1a1降水偏相关系数.tif']);reP(:,6)=reshape(da,m*n,1);
da=importdata([path,'l1a2降水偏相关系数.tif']);reP(:,7)=reshape(da,m*n,1);
da=importdata([path,'l2a0降水偏相关系数.tif']);reP(:,8)=reshape(da,m*n,1);
da=importdata([path,'l2a1降水偏相关系数.tif']);reP(:,9)=reshape(da,m*n,1);
da=importdata([path,'l3a0降水偏相关系数.tif']);reP(:,10)=reshape(da,m*n,1);
reP=abs(reP);
%% 判断
T_la=zeros(m*n,1);P_la=zeros(m*n,1);
for i=1:length(reT)
    Tpxg=reT(i,:);Ppxg=reP(i,:);
    if ~isnan(Tpxg(1))
       [~,ind]=max(Tpxg);
       T_la(i)=ind;
    end
    if ~isnan(Ppxg(1))
        [~,ind]=max(Ppxg);
        P_la(i)=ind;
    end
end
T_la=reshape(T_la,m,n);
P_la=reshape(P_la,m,n);
geotiffwrite([outpath,'NDVI与气温滞后累积效应时间.tif'],T_la,R,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);
geotiffwrite([outpath,'NDVI与降水滞后累积效应时间.tif'],P_la,R,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);




