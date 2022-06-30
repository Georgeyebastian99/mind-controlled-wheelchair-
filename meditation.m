function [y] = meditation(connectionId1)

data_med = zeros(1,256);

% Data type that can be requested from TG_GetValue().
TG_DATA_MEDITATION = 3;

fprintf( 'Connected. Reading  Meditation Packets...\n' );
i=0;
x=0;
while (i < 20 && x < 60)
    if (calllib('thinkgear64','TG_ReadPackets',connectionId1,1) == 1) %if a packet was read...
        if (calllib('thinkgear64','TG_GetValueStatus',connectionId1,TG_DATA_MEDITATION ) ~= 0)
            %Read attention Valus from thinkgear packets
            i = i + 1;
            data_med(i) = calllib('thinkgear64','TG_GetValue',connectionId1,TG_DATA_MEDITATION );
            x = data_med(i);
            %To display in Command Window
            disp(data_med(i));
            
            %Delay to display graph
            % pause(1);
        end
    end
end
y = x;
%To display in Command Window
disp('Meditation Loop Completed')
%Release the comm port
%calllib('thinkgear64', 'TG_FreeConnection', connectionId1 );