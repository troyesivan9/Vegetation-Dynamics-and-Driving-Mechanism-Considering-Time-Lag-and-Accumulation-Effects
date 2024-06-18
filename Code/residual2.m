pathV='E:\HBEY\lag&accumulation\KNDVI_Yearly\';   % NDVI·��
outpath='E:\HBEY\lag&accumulation\KNDVI&prt&rsd_Trend\';  % ������·��
[aa,R]=geotiffread([pathV,'KNDVI_2000.tif']); % ����һ��tif�ļ�
info=geotiffinfo([pathV,'KNDVI_2000.tif']);
[m,n]=size(aa);
%% Step2 һԪ���Իع����� 
data1=zeros(m*n,23); % Ԥ��
data2=zeros(m*n,23); % �в�
data3=zeros(m*n,23); % ��ֵ
for i=1:23
    filename=strcat('E:\HBEY\lag&accumulation\residual\KDNVI_prd_',int2str(i+1999),'.tif');
    bz=importdata(filename);
    bz=reshape(bz,m*n,1);
    data1(:,i)=bz;  
    filename=strcat('E:\HBEY\lag&accumulation\residual\KNDVI_rsd_',int2str(i+1999),'.tif');
    bz=importdata(filename);
    bz=reshape(bz,m*n,1);
    data2(:,i)=bz;  
    filename=strcat('E:\HBEY\lag&accumulation\KNDVI_Yearly\KNDVI_',int2str(i+1999),'.tif');
    bz=importdata(filename);
    bz=reshape(bz,m*n,1);
    data3(:,i)=bz;  
end
trend1=zeros(m,n);
trend2=zeros(m,n);
trend3=zeros(m,n);
for i=1:length(data1)
    % Ԥ��
    bz=data1(i,:);
    bz=bz';  
    X=[ones(size(bz)) bz];
    X(:,2)=[1:23]';
    [b,bint,r,rint,stats]=regress(bz,X);
    trend1(i)=b(2);
    % �в�
    bz=data2(i,:);
    bz=bz';  
    X=[ones(size(bz)) bz];
    X(:,2)=[1:23]';
    [b,bint,r,rint,stats]=regress(bz,X);
    trend2(i)=b(2);
    % ��ֵ
    bz=data3(i,:);
    bz=bz';  
    X=[ones(size(bz)) bz];
    X(:,2)=[1:23]';
    [b,bint,r,rint,stats]=regress(bz,X);
    trend3(i)=b(2);
end
geotiffwrite([outpath,'ndviԤ������.tif'],trend1,R,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);
geotiffwrite([outpath,'ndvi�в�����.tif'],trend2,R,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);
geotiffwrite([outpath,'ndvi��ֵ����.tif'],trend3,R,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);

