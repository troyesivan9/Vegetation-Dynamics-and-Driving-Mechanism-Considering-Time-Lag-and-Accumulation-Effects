pathV='E:\HBEY\lag&accumulation\KNDVI_Yearly\';   % NDVI路径
outpath='E:\HBEY\lag&accumulation\KNDVI&prt&rsd_Trend\';  % 结果存放路径
[aa,R]=geotiffread([pathV,'KNDVI_2000.tif']); % 任意一个tif文件
info=geotiffinfo([pathV,'KNDVI_2000.tif']);
[m,n]=size(aa);
%% Step3 贡献度
qihou=zeros(m,n)-999;  % 气候变化贡献度
renwei=zeros(m,n)-999; % 人类活动贡献度
obs=importdata([outpath,'KNDVI_original_trend.tif']);
climate=importdata([outpath,'KNDVI_prd_trend.tif']);
human=importdata([outpath,'KNDVI_rsd_trend.tif']);
index=find(obs>0&climate>0&human>0);
qihou(index)=climate(index)./obs(index)*100;
renwei(index)=human(index)./obs(index)*100;
index=find(obs>0&climate>0&human<0);
qihou(index)=100;
renwei(index)=0;
index=find(obs>0&climate<0&human>0);
qihou(index)=0;
renwei(index)=100;
index=find(obs<0&climate<0&human<0);
qihou(index)=climate(index)./obs(index)*100;
renwei(index)=human(index)./obs(index)*100;
index=find(obs<0&climate<0&human>0);
qihou(index)=100;
renwei(index)=0;
index=find(obs<0&climate>0&human<0);
qihou(index)=0;
renwei(index)=100;
geotiffwrite([outpath,'气候变化贡献度0.tif'],qihou,R,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);
geotiffwrite([outpath,'人类活动贡献度0.tif'],renwei,R,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);  