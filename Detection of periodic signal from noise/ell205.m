clear all;
close all;
clc;

f=input('Enter frequency: ');
ts=0.001;
t=0:ts:1;
s=sin(2*pi*f*t);
n=(rand(size(t))-0.5);
x=s+n;
subplot(2,1,1);
plot(t,x);
title('signal with noise');
% autocorrelation to get frequency of unknown signal x
[y,lags]=xcorr(x,x);
subplot(2,1,2);
plot(lags,y);
title('autocorrelation');

%computing the frequency
h=findobj(gca,'type','line');
y1=h.YData;
x1=h.XData;
d=find(x1==0);
m=movmean(y1,25);
while (m(d)>=m(d+1))
    d=d+1;
end
while (m(d)<=m(d+1))
    d=d+1;
end
d=d-1-1/ts;
freq=1/(d*ts);
freq;

%extracting the periodic part
 Xw=abs(fft(x));
 Lw=zeros(size(t));
 Lw(1:round(freq):end)=1;
 subplot(3,1,1);
 stem(t,Xw);
 title('Fourier Transform of x')
 subplot(3,1,2);
 stem(t,Lw);
 title('Fourier Transform of periodic signal with same period of s')
 Yw=Lw.*Xw;
 subplot(3,1,3);
 stem(t,Yw);
 title('Fourier Transform of the output y after filtering')
 y=(ifft(abs(Yw)));
 subplot(2,1,1);
 plot(t,x);
 title('Signal with noise');
 subplot(2,1,2);
 plot(t,y);
 title('Signal after extracting noise');