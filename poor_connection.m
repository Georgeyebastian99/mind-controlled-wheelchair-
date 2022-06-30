function [y] = poor_connection(connectionId1, time)

%Preallocate buffer
data_poor = zeros(1,256);

% Data type that can be requested from TG_GetValue().
TG_DATA_POOR_SIGNAL = 1;

i=0;
x=0;
%To display in Command Window
disp('Reading poor connection');

while (x < 1 && i<time) 
    if (calllib('thinkgear64','TG_ReadPackets',connectionId1,1) == 1) %if a packet was read...
        if (calllib('thinkgear64','TG_GetValueStatus',connectionId1,TG_DATA_POOR_SIGNAL ) ~= 0)
            i = i + 1;
            %Read attention Valus from thinkgear packets
            data_poor(i) = calllib('thinkgear64','TG_GetValue',connectionId1,TG_DATA_POOR_SIGNAL );
            if (data_poor(i) > 50)
                x = x + 1;
                y = x;
                disp('poor connection detected');
                
            end
            %To display in Command Window
            disp(data_poor(i));
            %pause(1);
        end
    end
end
y = x;

%To display in Command Window
disp('Poor Connection Loop Completed')