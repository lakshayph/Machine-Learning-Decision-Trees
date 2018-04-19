function [class_prob] = distribution(data,num_classes,unique_classes)

data_dimension = size(data,2);% number of columns in data matrix
classes = zeros(size(data,1),1);% initializing classes vector to 0
classes(:,1) = data(:,data_dimension); %defining classes vector
unique_new_classes = unique(classes);% displays different classes in ascending order
num_unique_classes = numel(unique_new_classes); % displays the number of classes
class_val = zeros(num_classes,1);% to store the count of number of elements belonging to different classes
class_prob = zeros(num_classes,1);

    for k = 1:num_unique_classes
        for i = 1:size(classes,1)
            if (classes(i,1) == unique_new_classes(k,1))
                if(unique_classes(1,1) == 0)
                    class_val(unique_new_classes(k,1)+1,1) = class_val(unique_new_classes(k,1)+1,1) + 1;
                else
                    class_val(unique_new_classes(k,1),1) = class_val(unique_new_classes(k,1),1) + 1;
                end
            end
        end
    end
    
    for j = 1:num_classes
        class_prob(j,1) = class_val(j,1)/size(classes,1);
    end
end

