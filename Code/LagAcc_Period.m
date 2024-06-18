clc
clear
[a,R]=geotiffread('E:\HBEY\lag&accumulation\KNDVI\2000_1_KNDVI.tif');  
info=geotiffinfo('E:\HBEY\lag&accumulation\KNDVI\2000_1_KNDVI.tif');
[m,n]=size(a);
path='E:\HBEY\lag&accumulation\Partial\';
outpath='E:\HBEY\lag&accumulation\Lag&Acc_Days\';
%% ����
reT=zeros(m*n,10); 
da=importdata([path,'l0a0����ƫ���ϵ��.tif']);reT(:,1)=reshape(da,m*n,1);
da=importdata([path,'l0a1����ƫ���ϵ��.tif']);reT(:,2)=reshape(da,m*n,1);
da=importdata([path,'l0a2����ƫ���ϵ��.tif']);reT(:,3)=reshape(da,m*n,1);
da=importdata([path,'l0a3����ƫ���ϵ��.tif']);reT(:,4)=reshape(da,m*n,1);
da=importdata([path,'l1a0����ƫ���ϵ��.tif']);reT(:,5)=reshape(da,m*n,1);
da=importdata([path,'l1a1����ƫ���ϵ��.tif']);reT(:,6)=reshape(da,m*n,1);
da=importdata([path,'l1a2����ƫ���ϵ��.tif']);reT(:,7)=reshape(da,m*n,1);
da=importdata([path,'l2a0����ƫ���ϵ��.tif']);reT(:,8)=reshape(da,m*n,1);
da=importdata([path,'l2a1����ƫ���ϵ��.tif']);reT(:,9)=reshape(da,m*n,1);
da=importdata([path,'l3a0����ƫ���ϵ��.tif']);reT(:,10)=reshape(da,m*n,1);
reT=abs(reT);
%% ��ˮ
reP=zeros(m*n,10); 
da=importdata([path,'l0a0��ˮƫ���ϵ��.tif']);reP(:,1)=reshape(da,m*n,1);
da=importdata([path,'l0a1��ˮƫ���ϵ��.tif']);reP(:,2)=reshape(da,m*n,1);
da=importdata([path,'l0a2��ˮƫ���ϵ��.tif']);reP(:,3)=reshape(da,m*n,1);
da=importdata([path,'l0a3��ˮƫ���ϵ��.tif']);reP(:,4)=reshape(da,m*n,1);
da=importdata([path,'l1a0��ˮƫ���ϵ��.tif']);reP(:,5)=reshape(da,m*n,1);
da=importdata([path,'l1a1��ˮƫ���ϵ��.tif']);reP(:,6)=reshape(da,m*n,1);
da=importdata([path,'l1a2��ˮƫ���ϵ��.tif']);reP(:,7)=reshape(da,m*n,1);
da=importdata([path,'l2a0��ˮƫ���ϵ��.tif']);reP(:,8)=reshape(da,m*n,1);
da=importdata([path,'l2a1��ˮƫ���ϵ��.tif']);reP(:,9)=reshape(da,m*n,1);
da=importdata([path,'l3a0��ˮƫ���ϵ��.tif']);reP(:,10)=reshape(da,m*n,1);
reP=abs(reP);
%% �ж�
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
geotiffwrite([outpath,'NDVI�������ͺ��ۻ�ЧӦʱ��.tif'],T_la,R,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);
geotiffwrite([outpath,'NDVI�뽵ˮ�ͺ��ۻ�ЧӦʱ��.tif'],P_la,R,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);




