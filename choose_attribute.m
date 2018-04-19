function [best_attribute, best_threshold, max_gain] = choose_attribute(data, dimension, type)

max_gain = -1;
best_attribute = -1;
best_threshold = -1;

if(strcmp(type,'optimized'))
    for col=1:dimension-1
        attrs = data(:,col);
        
        lower_val = min(attrs);
        upper_val = max(attrs);
        
        for k=1:50
            thresh = lower_val + (k*(upper_val - lower_val))/51;
            gain = information_gain(data, col, thresh);
            
            if (gain > max_gain)
                max_gain = gain;
                best_attribute = col;
                best_threshold = thresh;
            end
        end 
    end    
else
    col = datasample(1:dimension-1,1,'Replace',false);
    attr = data(:, col);
        lower_val = min(attr);
        upper_val = max(attr);
        for k=1:50
            thresh = lower_val + k*(upper_val - lower_val)/51;
            gain = information_gain(data, col, thresh);
            
            if (gain > max_gain)
                max_gain = gain;
                best_attribute = col;
                best_threshold = thresh;
            end
        end
end
end

