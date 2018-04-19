function [tree] = dtl(data, dimension, default, threshold, type, num_classes,unique_classes)
    if (size(data,1) < threshold) 
        [tree] = default; 
    elseif (size(unique(data(:,dimension))) == 1)
        [tree] = distribution(data, num_classes, unique_classes);
    else
        [best_attribute, best_threshold, max_gain] = choose_attribute(data, dimension, type); 
        tree = struct('best_attribute', best_attribute, 'best_threshold', best_threshold,'left_child', 0, 'right_child', 0, 'max_gain',max_gain); 
        data_left = [];
        data_right = [];
        for i=1:size(data,1)
            if (data(i,best_attribute) < best_threshold)
                data_left = [data_left;data(i,:)];
            else
                data_right = [data_right;data(i,:)]; 
            end
        end
        tree.left_child = dtl(data_left, dimension, distribution(data, num_classes, unique_classes), threshold, type, num_classes,unique_classes); 
        tree.right_child = dtl(data_right, dimension, distribution(data, num_classes, unique_classes), threshold, type, num_classes,unique_classes);   
    end
end

