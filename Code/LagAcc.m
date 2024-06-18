clc
clear
[a,R]=geotiffread('E:\HBEY\lag&accumulation\KNDVI\2000_1_KNDVI.tif');  
info=geotiffinfo('E:\HBEY\lag&accumulation\KNDVI\2000_1_KNDVI.tif');
m=size(a,1);
n=size(a,2);
Npath='E:\HBEY\lag&accumulation\KNDVI\';
Tpath='F:\Lag&Accum\Temperature\';
Ppath='E:\HBEY\lag&accumulation\Precipitation\';
Nfiles=dir([Npath,'*.tif']);Tfiles=dir([Tpath,'*.tif']);Pfiles=dir([Ppath,'*.tif']);
Nsum=zeros(m*n,276); % һ����һ���µ�����
Tsum=zeros(m*n,276);
Psum=zeros(m*n,276);
k=1;
for year=2000:2022
    for month=1:12
        ndvi=importdata([Npath,int2str(year),'_',int2str(month),'_','KNDVI.tif']);
        Nsum(:,k)=reshape(ndvi,m*n,1);
        temp=importdata([Tpath,int2str(year),'_',int2str(month),'_','T.tif']);
        Tsum(:,k)=reshape(temp,m*n,1);
        prec=importdata([Ppath,int2str(year),'_',int2str(month),'_','P.tif']);
        Psum(:,k)=reshape(prec,m*n,1);
        k=k+1;
    end
end
% ������Ԫ�ÿ�
ind1=find(Nsum<0);ind2=find(Tsum<-500);ind3=find(Psum<0);ind=union(ind1,ind2);ind=union(ind,ind3);
Nsum(ind)=nan;Tsum(ind)=nan;Psum(ind)=nan;
outpath='E:\HBEY\lag&accumulation\Partial\';

%% l-a 0-0 8�º�8�� ...
T_pxg=zeros(m*n,1)+nan;P_pxg=zeros(m*n,1)+nan;
for i=1:m*n
    Ni=Nsum(i,:);Ti=Tsum(i,:);Pi=Psum(i,:);
    [rho,~]=partialcorr(Ni',Ti',Pi');T_pxg(i)=rho;
    [rho,~]=partialcorr(Ni',Pi',Ti');P_pxg(i)=rho;
end
T_pxg=reshape(T_pxg,m,n);P_pxg=reshape(P_pxg,m,n);
geotiffwrite([outpath,'l0a0����ƫ���ϵ��.tif'],T_pxg,R,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);
geotiffwrite([outpath,'l0a0��ˮƫ���ϵ��.tif'],P_pxg,R,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);

%% l-a 0-1 8�º�(7+8)/2 ...�ۻ�����
% P��T��������ȡƽ��
newTsum=zeros(m*n,275);newPsum=zeros(m*n,275);
for i=1:275
    newTsum(:,i)=mean(Tsum(:,i:i+1),2);
    newPsum(:,i)=mean(Psum(:,i:i+1),2);
end
newNsum=Nsum(:,2:276);
T_pxg=zeros(m*n,1)+nan;P_pxg=zeros(m*n,1)+nan; % 
for i=1:m*n
    Ni=newNsum(i,:);Ti=newTsum(i,:);Pi=newPsum(i,:);
    [rho,~]=partialcorr(Ni',Ti',Pi');T_pxg(i)=rho;
    [rho,~]=partialcorr(Ni',Pi',Ti');P_pxg(i)=rho;
end
T_pxg=reshape(T_pxg,m,n);P_pxg=reshape(P_pxg,m,n);
geotiffwrite([outpath,'l0a1����ƫ���ϵ��.tif'],T_pxg,R,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);
geotiffwrite([outpath,'l0a1��ˮƫ���ϵ��.tif'],P_pxg,R,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);

%% l-a 0-2 8�º�(6+7+8)/3 ...�ۻ�����
% P��T��������ȡƽ��
newTsum=zeros(m*n,274);newPsum=zeros(m*n,274);
for i=1:274
    newTsum(:,i)=mean(Tsum(:,i:i+2),2);
    newPsum(:,i)=mean(Psum(:,i:i+2),2);
end
newNsum=Nsum(:,3:276);
T_pxg=zeros(m*n,1)+nan;P_pxg=zeros(m*n,1)+nan; % 
for i=1:m*n
    Ni=newNsum(i,:);Ti=newTsum(i,:);Pi=newPsum(i,:);
    [rho,~]=partialcorr(Ni',Ti',Pi');T_pxg(i)=rho;
    [rho,~]=partialcorr(Ni',Pi',Ti');P_pxg(i)=rho;
end
T_pxg=reshape(T_pxg,m,n);P_pxg=reshape(P_pxg,m,n);
geotiffwrite([outpath,'l0a2����ƫ���ϵ��.tif'],T_pxg,R,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);
geotiffwrite([outpath,'l0a2��ˮƫ���ϵ��.tif'],P_pxg,R,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);

%% l-a 0-3 8�º�(5+6+7+8)/4 ...�ۻ�����
% P��T��������ȡƽ��
newTsum=zeros(m*n,273);newPsum=zeros(m*n,273);
for i=1:273
    newTsum(:,i)=mean(Tsum(:,i:i+3),2);
    newPsum(:,i)=mean(Psum(:,i:i+3),2);
end
newNsum=Nsum(:,4:276);
T_pxg=zeros(m*n,1)+nan;P_pxg=zeros(m*n,1)+nan; % 
for i=1:m*n
    Ni=newNsum(i,:);Ti=newTsum(i,:);Pi=newPsum(i,:);
    [rho,~]=partialcorr(Ni',Ti',Pi');T_pxg(i)=rho;
    [rho,~]=partialcorr(Ni',Pi',Ti');P_pxg(i)=rho;
end
T_pxg=reshape(T_pxg,m,n);P_pxg=reshape(P_pxg,m,n);
geotiffwrite([outpath,'l0a3����ƫ���ϵ��.tif'],T_pxg,R,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);
geotiffwrite([outpath,'l0a3��ˮƫ���ϵ��.tif'],P_pxg,R,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);

%% l-a 1-0 8�º�7�� ...�ͺ�һ��
newTsum=Tsum(:,1:275);
newPsum=Psum(:,1:275);
newNsum=Nsum(:,2:276);
T_pxg=zeros(m*n,1)+nan;P_pxg=zeros(m*n,1)+nan; % 
for i=1:m*n
    Ni=newNsum(i,:);Ti=newTsum(i,:);Pi=newPsum(i,:);
    [rho,~]=partialcorr(Ni',Ti',Pi');T_pxg(i)=rho;
    [rho,~]=partialcorr(Ni',Pi',Ti');P_pxg(i)=rho;
end
T_pxg=reshape(T_pxg,m,n);P_pxg=reshape(P_pxg,m,n);
geotiffwrite([outpath,'l1a0����ƫ���ϵ��.tif'],T_pxg,R,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);
geotiffwrite([outpath,'l1a0��ˮƫ���ϵ��.tif'],P_pxg,R,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);

%% l-a 1-1 8�º�(6+7)/2 ...�ͺ�һ��&�ۻ�����
% P��T��������ȡƽ��
newTsum=zeros(m*n,274);newPsum=zeros(m*n,274);
for i=1:274
    newTsum(:,i)=mean(Tsum(:,i:i+1),2);
    newPsum(:,i)=mean(Psum(:,i:i+1),2);
end
newNsum=Nsum(:,3:276);
T_pxg=zeros(m*n,1)+nan;P_pxg=zeros(m*n,1)+nan; % 
for i=1:m*n
    Ni=newNsum(i,:);Ti=newTsum(i,:);Pi=newPsum(i,:);
    [rho,~]=partialcorr(Ni',Ti',Pi');T_pxg(i)=rho;
    [rho,~]=partialcorr(Ni',Pi',Ti');P_pxg(i)=rho;
end
T_pxg=reshape(T_pxg,m,n);P_pxg=reshape(P_pxg,m,n);
geotiffwrite([outpath,'l1a1����ƫ���ϵ��.tif'],T_pxg,R,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);
geotiffwrite([outpath,'l1a1��ˮƫ���ϵ��.tif'],P_pxg,R,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);

%% l-a 1-2 8�º�(5+6+7)/3 ...�ͺ�һ��&�ۻ�����
% P��T��������ȡƽ�� 
newTsum=zeros(m*n,273);newPsum=zeros(m*n,273);
for i=1:273
    newTsum(:,i)=mean(Tsum(:,i:i+2),2);
    newPsum(:,i)=mean(Psum(:,i:i+2),2);
end
newNsum=Nsum(:,4:276);
T_pxg=zeros(m*n,1)+nan;P_pxg=zeros(m*n,1)+nan; % 
for i=1:m*n
    Ni=newNsum(i,:);Ti=newTsum(i,:);Pi=newPsum(i,:);
    [rho,~]=partialcorr(Ni',Ti',Pi');T_pxg(i)=rho;
    [rho,~]=partialcorr(Ni',Pi',Ti');P_pxg(i)=rho;
end
T_pxg=reshape(T_pxg,m,n);P_pxg=reshape(P_pxg,m,n);
geotiffwrite([outpath,'l1a2����ƫ���ϵ��.tif'],T_pxg,R,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);
geotiffwrite([outpath,'l1a2��ˮƫ���ϵ��.tif'],P_pxg,R,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);

%% l-a 2-0 8�º�6�� ...�ͺ�����
newTsum=Tsum(:,1:274);
newPsum=Psum(:,1:274);
newNsum=Nsum(:,3:276);
T_pxg=zeros(m*n,1)+nan;P_pxg=zeros(m*n,1)+nan;
for i=1:m*n
    Ni=newNsum(i,:);Ti=newTsum(i,:);Pi=newPsum(i,:);
    [rho,~]=partialcorr(Ni',Ti',Pi');T_pxg(i)=rho;
    [rho,~]=partialcorr(Ni',Pi',Ti');P_pxg(i)=rho;
end
T_pxg=reshape(T_pxg,m,n);P_pxg=reshape(P_pxg,m,n);
geotiffwrite([outpath,'l2a0����ƫ���ϵ��.tif'],T_pxg,R,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);
geotiffwrite([outpath,'l2a0��ˮƫ���ϵ��.tif'],P_pxg,R,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);

%% l-a 2-1 8�º�(5+6)/2 ...�ͺ�����&�ۻ�����
% P��T��������ȡƽ��
newTsum=zeros(m*n,273);newPsum=zeros(m*n,273);
for i=1:273
    newTsum(:,i)=mean(Tsum(:,i:i+1),2);
    newPsum(:,i)=mean(Psum(:,i:i+1),2);
end
newNsum=Nsum(:,4:276);
T_pxg=zeros(m*n,1)+nan;P_pxg=zeros(m*n,1)+nan; % 
for i=1:m*n
    Ni=newNsum(i,:);Ti=newTsum(i,:);Pi=newPsum(i,:);
    [rho,~]=partialcorr(Ni',Ti',Pi');T_pxg(i)=rho;
    [rho,~]=partialcorr(Ni',Pi',Ti');P_pxg(i)=rho;
end
T_pxg=reshape(T_pxg,m,n);P_pxg=reshape(P_pxg,m,n);
geotiffwrite([outpath,'l2a1����ƫ���ϵ��.tif'],T_pxg,R,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);
geotiffwrite([outpath,'l2a1��ˮƫ���ϵ��.tif'],P_pxg,R,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);

%% l-a 3-0 8�º�5�� ...�ͺ�����
newTsum=Tsum(:,1:273);
newPsum=Psum(:,1:273);
newNsum=Nsum(:,4:276);
T_pxg=zeros(m*n,1)+nan;P_pxg=zeros(m*n,1)+nan; % 
for i=1:m*n
    Ni=newNsum(i,:);Ti=newTsum(i,:);Pi=newPsum(i,:);
    [rho,~]=partialcorr(Ni',Ti',Pi');T_pxg(i)=rho;
    [rho,~]=partialcorr(Ni',Pi',Ti');P_pxg(i)=rho;
end
T_pxg=reshape(T_pxg,m,n);P_pxg=reshape(P_pxg,m,n);
geotiffwrite([outpath,'l3a0����ƫ���ϵ��.tif'],T_pxg,R,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);
geotiffwrite([outpath,'l3a0��ˮƫ���ϵ��.tif'],P_pxg,R,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);
