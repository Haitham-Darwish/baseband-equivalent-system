clc;clear;close all;
NumberofBits = 36000;
Data=randi([0,1],[NumberofBits, 1]);
No = 10.^[-10:0.1:3];


% For Binary Phase shift key
SI_B=2*Data-1;

% Get average symbol error and bit energy
avg_symbol_energy=2/2;
Eb_B=avg_symbol_energy/1;
B_BER=zeros(length(No), 1);
Noise=sqrt(No/2).*randn(NumberofBits, length(No));
X_Bs=repmat(SI_B, 1, length(No))+Noise;

% BPSK RX
B_RXs=X_Bs>0;
B_BERs=sum(B_RXs~=Data)/NumberofBits;

theoritical_error_B=1/2*erfc(sqrt(Eb_B./No));

hold on
semilogy(10*log10(Eb_B./No),B_BERs, 'b');
semilogy(10*log10(Eb_B./No),theoritical_error_B, 'bo');
hold off
legend('BER of BPSK', 'BER theoretical');
title('BER vs EB/No');
xlabel('Eb/No in dB'); ylabel('BER');
%======================================================================%
% For Quadri-Phase Shift Keying (QPSK)
i=1;
SI=zeros(length(Data)/2, 1);
SQ=zeros(length(Data)/2, 1);
da=zeros(length(Data)/2, 2);
Noise=sqrt(No/2).*randn(NumberofBits/2, length(No))+sqrt(No/2).*randn(NumberofBits/2, length(No))*j;
% Mapper
for d=1:2:length(Data),
    da(i, :)=Data(d:d+1);
    
    if da(i, 1)==0,
        SI(i)=-1;
    else
        SI(i)=1;
    end
    
    if da(i, 2)==0,
        SQ(i)=-1;
    else
        SQ(i)=1;
    end
    
    i=i+1;
end
S_QPSK=SI+SQ*j;
X_QPSK=S_QPSK+Noise;

QPSK_RX=zeros(length(Data), length(No));
QPSK_RX(1:2:length(Data), :)=real(X_QPSK)>0 ;
QPSK_RX(2:2:length(Data), :)=imag(X_QPSK)>0;

QPSK_BER=sum(QPSK_RX~=Data)/NumberofBits

% Get average symbola dand bit energy
avg_symbol_energy=4*(1+1)/4;
Eb_QPSK=avg_symbol_energy/2
theoritical_error_QPSK=1/2*erfc(sqrt(Eb_QPSK./No));
hold on
semilogy(10*log10(Eb_QPSK./No),QPSK_BER, 'r*');
semilogy(10*log10(Eb_QPSK./No),theoritical_error_QPSK, 'r');
hold off
%legend('BER of QPSK', 'BER QPSK theoretical');
title('BER vs EB/No');
xlabel('Eb/No in dB'); ylabel('BER');

% For Quadrature Amplitude Modulation (QAM)
i=1;
SI_QAM=zeros(length(Data)/4, 1);
SQ_QAM=zeros(length(Data)/4, 1);
da=zeros(length(Data)/4, 4);
Noise=sqrt(No/2).*randn(NumberofBits/4, 1)+sqrt(No/2).*randn(NumberofBits/4, 1)*j;
for d=1:4:length(Data),
    da(i, :)=Data(d:d+3);
    
    if da(i, 1)==0 && da(i, 2)==0,
        SI_QAM(i)=-3;    
    elseif da(i, 1)==0 && da(i, 2)==1,
        SI_QAM(i)=-1;
    elseif da(i, 1)==1 && da(i, 2)==1,
        SI_QAM(i)=1;
    elseif da(i, 1)==1 && da(i, 2)==0,
        SI_QAM(i)=3;
    end
    
    if da(i, 3)==0 && da(i, 4)==0,
        SQ_QAM(i)=-3;
    elseif da(i, 3)==0 && da(i, 4)==1,
        SQ_QAM(i)=-1;
    elseif da(i, 3)==1 && da(i, 4)==1,
        SQ_QAM(i)=1;
    elseif da(i, 3)==1 && da(i, 4)==0,
        SQ_QAM(i)=3;
    end
    
    
    
    i=i+1;
end
S_QAM=SI_QAM+SQ_QAM*j;
X_QAM=S_QAM+Noise;

avg_symbol_energy=(4*(3^2+3^2)+4*(1+1)+8*(3^2+1))/16;
Eb_QAM=avg_symbol_energy/4;
theoritical_error_QAM=3/8*erfc(sqrt(Eb_QAM./(2.5*No)));

QAM_RX=zeros(length(Data), length(No));
QAM_RX(1:4:length(Data), :)=real(X_QAM)>0;
QAM_RX(2:4:length(Data), :)=abs(real(X_QAM))<2;

QAM_RX(3:4:length(Data), :)=imag(X_QAM)>0;
QAM_RX(4:4:length(Data), :)=abs(imag(X_QAM))<2;



% Get bit error rate
QAM_BER=sum(QAM_RX~=Data)/NumberofBits;

% Plot the Bit error rate vs Eb/No in dB
hold on
semilogy(10*log10(Eb_QAM./No),QAM_BER, 'ko');
semilogy(10*log10(Eb_QAM./No),theoritical_error_QAM, 'k');
hold off
legend('BER of BPSK', 'BER theoretical', 'BER of QPSK', 'BER QPSK theoretical', 'BER of QAM', 'QAM BER theoretical');
title('BER vs EB/No');
xlabel('Eb/No in dB'); ylabel('BER');




% For 8 Phase shift key (8PSK)
i=1;
SI_PSK=zeros(length(Data)/3, 1);
da=zeros(length(Data)/3, 3);
Noise=sqrt(No/2).*randn(NumberofBits/3, length(No))+sqrt(No/2).*randn(NumberofBits/3, length(No))*j;
for d=1:3:length(Data),
    da(i, :)=Data(d:d+2);
    
    if da(i, 1)==0 && da(i, 2)==0 && da(i, 3)==0,
        SI_PSK(i)=1;    
    elseif da(i, 1)==0 && da(i, 2)==0 && da(i, 3)==1,
        SI_PSK(i)=1/sqrt(2)+1/sqrt(2)*j;
    elseif da(i, 1)==0 && da(i, 2)==1 && da(i, 3)==1,
        SI_PSK(i)=j;
    elseif da(i, 1)==0 && da(i, 2)==1 && da(i, 3)==0,
        SI_PSK(i)=-1/sqrt(2)+1/sqrt(2)*j;
    elseif da(i, 1)==1 && da(i, 2)==1 && da(i, 3)==0,
        SI_PSK(i)=-1;
    elseif da(i, 1)==1 && da(i, 2)==1 && da(i, 3)==1,
        SI_PSK(i)=-1/sqrt(2)-1/sqrt(2)*j;
    elseif da(i, 1)==1 && da(i, 2)==0 && da(i, 3)==1,
        SI_PSK(i)=-j; 
    elseif da(i, 1)==1 && da(i, 2)==0 && da(i, 3)==0,
        SI_PSK(i)=1/sqrt(2)-1/sqrt(2)*j;
    end
    
    i=i+1;
end
X_PSK=SI_PSK+Noise;

avg_symbol_energy=8/8;
Eb_PSK=avg_symbol_energy/3

theoritical_error_PSK=7/2*erfc(sqrt(3*Eb_PSK./No)*sin(pi/8))/3;
theoritical_error_tight_bound=2/2*erfc(sqrt(3*Eb_PSK./No)*sin(pi/8))/3;


%===================8PSK====================

PSK_RX=zeros(length(Data), length(No));

%PSK_RX=repmat(Data, 1, length(No));
PSK_RX(1:3:length(Data), :)=~((angle(X_PSK)>=-pi/8) .* (angle(X_PSK)<=7*pi/8));%imag(X_PSK)<0;


PSK_RX(2:3:length(Data), :)=((angle(X_PSK)>3*pi/8)+(angle(X_PSK)<-5*pi/8));


PSK_RX(3:3:length(Data), :)=(((angle(X_PSK)>pi/8).*(angle(X_PSK)<5*pi/8)) + ...
                              ((angle(X_PSK)<-3*pi/8).*(angle(X_PSK)>-7*pi/8)));
PSK_BER=sum(PSK_RX~=Data)/NumberofBits;

 
hold on
semilogy(10*log10(Eb_PSK./No),PSK_BER, 'c');
%semilogy(10*log10(Eb_PSK./No),theoritical_error_PSK);
semilogy(10*log10(Eb_PSK./No),theoritical_error_tight_bound, 'co');
hold off
%legend('BER of 8PSK','8PSK BER tight bound');
legend('BER of BPSK', 'BER theoretical', 'BER of QPSK', ...
      'BER QPSK theoretical', 'BER of QAM', 'QAM BER theoretical',...
      'BER of 8PSK', '8PSK BER tight bound');

title('BER vs EB/No');
xlabel('Eb/No in dB'); ylabel('BER');
yticks(10.^[-6:1:0])
xticks([0:2:24])
ylim([10^-6 10^0])
xlim([0 15])
set(gca, 'YScale', 'log')
