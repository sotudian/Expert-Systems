% Question 2 Shahab Sotudian --- 94125091
% bridge construction expert system
clear
clc
%%  Backward Chaining 

TimeForce=input('Is there any force to complete project as soon as possible? (y/n) ','s');
if strcmp(TimeForce,'y');
    WeldingCrew=input('Is there sufficient welding crew? (y/n) ','s');
    if strcmp(WeldingCrew,'y');
        SteelFactory=input('Is there any Steel Factory near your site? (y/n) ','s');
        if strcmp(SteelFactory,'y');
            'Suspension bridge is proper'
        elseif strcmp(SteelFactory,'n');
            'Arch bridge is proper'
        else
            'please correct your entries and try again!'
        end
    elseif strcmp(wel_cre,'n');
        TemperatureTepid=input('Is temperature tepid (Neither so high nor so low)? (y/n) ','s');
        if strcmp(TemperatureTepid,'y');
            AirHumidity=input('Is air humidity too high? (y/n) ','s');
            if strcmp(AirHumidity,'y');
                'Arch bridge is proper'
            elseif strcmp(AirHumidity,'n');
                TrafficCondition=input('Is traffic too high? (y/n) ','s');
                if strcmp(TrafficCondition,'y');
                    'Suspension bridge is proper'
                elseif strcmp(TrafficCondition,'n');
                    ConcreteBatching=input('Is there any Concrete batching is near your site? (y/n) ','s');
                    if strcmp(ConcreteBatching,'y');
                        con_cas=input('Is Concrete casting equipment available? (y/n) ','s');
                        if strcmp(con_cas,'y');
                            'Arch bridge is proper'
                        elseif strcmp(con_cas,'n');
                            'Suspension bridge is proper'
                        else
                            'please correct your entries and try again!'
                        end
                    elseif strcmp(ConcreteBatching,'n');
                        'Suspension bridge is proper'
                    else
                        'please correct your entries and try again!'
                    end
                else
                    'please correct your entries and try again!'
                end
            else
                'please correct your entries and try again!'
            end
        elseif strcmp(TemperatureTepid,'n')
            SteelFactory=input('Is there any Steel Factory near your site? (y/n) ','s');
            if strcmp(SteelFactory,'y');
                'Suspension bridge is proper'
            elseif strcmp(SteelFactory,'n');
                'Arch bridge is proper'
            else
                'please correct your entries and try again!'
            end
        else
            'please correct your entries and try again!'
        end
    else
        'please correct your entries and try again!'
    end
elseif strcmp(TimeForce,'n');
    TemperatureTepid=input('Is temperature tepid (Neither so high nor so low)? (y/n) ','s');
    if strcmp(TemperatureTepid,'y');
        AirHumidity=input('Is air humidity too high?y/n','s');
        if strcmp(AirHumidity,'y');
            'Arch bridge is proper'
        elseif strcmp(AirHumidity,'n');
            TrafficCondition=input('Is traffic too high? (y/n) ','s');
            if strcmp(TrafficCondition,'y');
                'Suspension bridge is proper'
            elseif strcmp(TrafficCondition,'n');
                ConcreteBatching=input('Is there any Concrete batching is near your site? (y/n) ','s');
                if strcmp(ConcreteBatching,'y');
                    con_cas=input('Is Concrete casting equipment available? (y/n) ','s');
                    if strcmp(con_cas,'y');
                        'Arch bridge is proper'
                    elseif strcmp(con_cas,'n');
                        'Suspension bridge is proper'
                    else
                        'please correct your entries and try again!'
                    end
                elseif strcmp(ConcreteBatching,'n');
                    'Suspension bridge is proper'
                else
                    'please correct your entries and try again!'
                end
            else
                'please correct your entries and try again!'
            end
        else
            'please correct your entries and try again!'
        end
    elseif strcmp(TemperatureTepid,'n');
        SteelFactory=input('Is there any Steel Factory near your site? (y/n) ','s');
        if strcmp(SteelFactory,'y');
            'Suspension bridge is proper'
        elseif strcmp(SteelFactory,'n');
            'Arch bridge is proper'
        else
            'please correct your entries and try again!'
        end
    else
        'please correct your entries and try again!'
    end
else
    'please correct your entries and try again!'
end

%%  Forward Chaining to Determine structure of Arch bridge 
if strcmp(ans,'Arch bridge is proper')
    ext_mon=input('Do you pay extra money for architecture? (y/n) ','s');
    if strcmp(ext_mon,'y');
        mas_con=input('Do you have massive concrete casting equipment? (y/n) ','s');
        if strcmp(mas_con,'y');
            two_thr=input('Is traffic too high?? (y/n) ','s');
            if strcmp(two_thr,'y');
                'Concrete structure with shear wall'
            elseif strcmp(two_thr,'n');
                'Both Concrete with and without shear wall'
            else
                'please correct your entries and try again!'
            end
        elseif strcmp(mas_con,'n');
            tal_bui=input('Height of bridge is more than 220 ft. ? (y/n) ','s');
            if strcmp(tal_bui,'y');
                mas_con=input('Do you have massive concrete casting equipment? (y/n) ','s');
                if strcmp(mas_con,'y');
                    'Concrete structure with shear wall'
                elseif strcmp(mas_con,'n');
                    'Concrete structure with shear wall should be used but you have not proper equipment'
                else
                    'please correct your entries and try again!'
                end
            elseif strcmp(tal_bui,'n');
                'Both Concrete with and without shear wall'
            else
                'please correct your entries and try again!'
            end
        else
            'please correct your entries and try again!'
        end
    elseif strcmp(ext_mon,'n');
        tal_bui=input('Height of bridge is more than 220 ft. ? (y/n) ','s');
        if strcmp(tal_bui,'y');
            mas_con=input('Do you have massive concrete casting equipment? (y/n) ','s');
            if strcmp(mas_con,'y');
                'Concrete structure with shear wall'
            elseif strcmp(mas_con,'n');
                'Concrete structure with shear wall should be used but you have not proper equipment'
            else
                'please correct your entries and try again!'
            end
        elseif strcmp(tal_bui,'n');
            'Both Concrete with and without shear wall'
        else
            'please correct your entries and try again!'
        end
    else
        'please correct your entries and try again!'
    end
    
    %%  Forward Chaining to Determine structure of Suspension bridge 
elseif strcmp(ans,'Suspension bridge is proper')
    imp_spe=input('Implementation speed is so important? (y/n) ','s');
    if strcmp(imp_spe,'y');
        mas_con=input('Massive construction? (y/n) ','s');
        if strcmp(mas_con,'y');
            bol_fac=input('Bolt and nut factory is near? (y/n) ','s');
            if strcmp(bol_fac,'y');
                'Bolt and nut steel structure'
            elseif strcmp(bol_fac,'n');
                'Welding steel structure'
            else
                'please correct your entries and try again!'
            end
        elseif strcmp(mas_con,'n');
            'Welding steel structure'
        else
            'please correct your entries and try again!'
        end
    elseif strcmp(imp_spe,'n');
        mas_con=input('Massive construction? (y/n) ','s');
        if strcmp(mas_con,'y');
            'Both Welding and Bolt & nut steel structure'
        elseif strcmp(mas_con,'n');
            'Welding steel structure'
        else
            'please correct your entries and try again!'
        end
    else
        'please correct your entries and try again!'
    end
end