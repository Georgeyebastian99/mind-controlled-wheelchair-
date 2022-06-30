function [y] = blink(connectionId1,m)

%Preallocate buffer
data_blink = zeros(1,256);

% Data type that can be requested from TG_GetValue()
TG_DATA_BLINK_STRENGTH = 37;

if(calllib('thinkgear64','TG_EnableBlinkDetection',connectionId1,1)==0)
    disp('blink detect enabled');
end

i=0;
x=0;
y=0;
%To display in Command Window
disp('Reading Brainwaves');
while (i < 3000 && y<m)
    if (calllib('thinkgear64','TG_ReadPackets',connectionId1,1) == 1) %if a packet was read...
        i = i + 1;
        if (calllib('thinkgear64','TG_GetValueStatus',connectionId1,TG_DATA_BLINK_STRENGTH) ~= 0)
            %Read attention Valus from thinkgear packets
            data_blink(i) = calllib('thinkgear64','TG_GetValue',connectionId1,TG_DATA_BLINK_STRENGTH);
            %To display in Command Window
            disp(data_blink(i));
            x = data_blink(i);
            if (x > 0)
                y = y + 1;
            end
        end
    end
end

%To display in Command Window
disp('Blink Loop Completed')