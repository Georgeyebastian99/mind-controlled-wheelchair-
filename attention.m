function [y] = attention(connectionId1)

%Preallocate buffer
data_att = zeros(1,256);

% Data type that can be requested from TG_GetValue().
TG_DATA_ATTENTION = 2;

% Attempt to connect the connection ID handle to serial port "COM3"

fprintf( 'Connected. Reading Packets...\n' );

i=0;
x=0;

%To display in Command Window
disp('Reading Attention Brainwaves');
while (x < 50 && i < 20)
    if (calllib('thinkgear64','TG_ReadPackets',connectionId1,1) == 1) %if a packet was read...
        if (calllib('thinkgear64','TG_GetValueStatus',connectionId1,TG_DATA_ATTENTION ) ~= 0)
            i = i + 1;
            %Read attention Valus from thinkgear packets
            data_att(i) = calllib('thinkgear64','TG_GetValue',connectionId1,TG_DATA_ATTENTION );
            x = data_att(i);
            %To display in Command Window
            disp(x);
        end
    end
end
y = x;
%To display in Command Window
disp('Attention Loop Completed')