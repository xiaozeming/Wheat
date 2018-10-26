clear
clc
load wheatseeds.mat  %��210*7ά����
%wheatseeds.mat���Է�Ϊ3��(1,2,3);
%��һ��Ϊ��1-70�����ݣ��ڶ���Ϊ��71-140�����ݣ�������Ϊ��141-210������;
%��wheatseeds.mat�����ݷֳ���������ѵ������trdata�Ͳ�������tedata;
%trdata����ÿ�����ݵ�ǰ40��;tedata����ÿ�����ݵĺ�30�У�
%���ݷ������£�

trdata1=wheatseeds(1:40,1:7);
tedata1=wheatseeds(41:70,1:7);
trdata2=wheatseeds(71:110,1:7);
tedata2=wheatseeds(111:140,1:7);
trdata3=wheatseeds(141:180,1:7);
tedata3=wheatseeds(181:210,1:7);
trdata=[trdata1;trdata2;trdata3];
tedata=[tedata1;tedata2;tedata3];


%����wheatseeds.mat��ÿһ�ࡢÿһά��������̬�ֲ�;
%�ֱ����3�����ӵ�7��������׼�ľ�ֵ�ͷ���;
mean=zeros(3,7);    %��ֵ
sigma=zeros(3,7);   %����
for i=1:7
    [mean(1,i),sigma(1,i)]=normfit(trdata1(:,i));
    [mean(2,i),sigma(2,i)]=normfit(trdata2(:,i));
    [mean(3,i),sigma(3,i)]=normfit(trdata3(:,i));
end

%�����ر�Ҷ˹������Ȼ����;
posterior=zeros(3,90); %�������
priori=zeros(3,1);     %�������
class=zeros(90,1);
for i=1:90
    for j=1:3
        if j==1
           priori(j,1)=70/210;  %���1���������
        elseif j==2
            priori(j,1)=70/210;  %���2���������
        else 
            priori(j,1)=70/210;  %���3���������
        end
        likelihood=ones(3,1);   %������Ȼ����
        for d=1:7
            likelihood(j,1)=likelihood(j,1)*normpdf(tedata(i,d),mean(j,d),sigma(j,d));
        end
        posterior(j,i)=likelihood(j,1)*priori(j,1);  %����������
    end
    C=posterior(:,i);  
    [m,n]=max(C);   %ѡ����������ʶ�Ӧ�����
    class(i,1)=n;   %��90���������ݷ��࣬����90*1�ľ���
end

%���������ȷ�ĸ��ʣ�a���������ȷ��b����������
a1=0;
a2=0;
a3=0;
b1=0;
b2=0;
b3=0;
for k=1:30
    if class(k)==1
        a1=a1+1;
    else 
        b1=b1+1;
    end
end
for k=31:60
    if class(k)==2
        a2=a2+1;
    else 
        b2=b2+1;
    end
end
for k=61:90
    if class(k)==3
        a3=a3+1;
    else 
        b3=b3+1;
    end
end
a=a1+a2+a3;
b=b1+b2+b3;
true_per=a/90;
false_per=b/90;

%��ͼչʾ��7�ֱ�׼�����ݵķ������;
%��һ������Ϊ��ɫ���ڶ�������Ϊ��ɫ������������Ϊ��ɫ;
figure; 
subplot(3,3,1);
hold on
scatter(1:90,tedata(:,1),20,class,'filled');
plot([30,30],[0,25],'--k');%�ָ���
plot([60,60],[0,25],'--k');
xlabel('sample');
ylabel('area');            %��׼1������
hold off

subplot(3,3,2);
hold on
scatter(1:90,tedata(:,2),20,class,'filled');
plot([30,30],[0,20],'--k');%�ָ���
plot([60,60],[0,20],'--k');
xlabel('sample');
ylabel('girth');           %��׼2���ܳ�

subplot(3,3,3);
hold on
scatter(1:90,tedata(:,3),20,class,'filled');
plot([30,30],[0,20],'--k');%�ָ���
plot([60,60],[0,20],'--k');
xlabel('sample');
ylabel('puddlability');    %��׼3��ѹʵ��
hold off

subplot(3,3,4);
hold on
scatter(1:90,tedata(:,4),20,class,'filled');
plot([30,30],[0,20],'--k');%�ָ���
plot([60,60],[0,20],'--k');
xlabel('sample');
ylabel('grainlength');
hold off

subplot(3,3,5);
hold on
scatter(1:90,tedata(:,5),20,class,'filled');
plot([30,30],[0,20],'--k');%�ָ���
plot([60,60],[0,20],'--k');
xlabel('sample');
ylabel('grainwidth');
hold off

subplot(3,3,6);
hold on
scatter(1:90,tedata(:,6),20,class,'filled');
plot([30,30],[0,20],'--k');%�ָ���
plot([60,60],[0,20],'--k');
xlabel('sample');
ylabel('dissymmetry coefficient');
hold off

subplot(3,3,7);
hold on
scatter(1:90,tedata(:,7),20,class,'filled');
plot([30,30],[0,20],'--k');%�ָ���
plot([60,60],[0,20],'--k');
xlabel('sample');
ylabel('grain ventral length');
hold off



