function print_funct(tree,val)
dummy_node = []; 
index = 1;
dummy_node = [dummy_node;tree];

%x = size(dummy_node,1);
%disp(x);

    while(size(dummy_node,1) >= index)
       fprintf('tree=%2d, node=%3d, feature=%2d, thr=%6.2f, gain=%f\n', val, index, (dummy_node(index).best_attribute-1), dummy_node(index).best_threshold, dummy_node(index).max_gain);
      
        if (isstruct(dummy_node(index,1).left_child))
            dummy_node = [dummy_node;dummy_node(index,1).left_child];
        elseif (length(dummy_node(index,1).left_child)>1)
            dummy_node = [dummy_node; struct('best_attribute', 0, 'best_threshold',-1,'left_child', 0, 'right_child', 0, 'max_gain',-1)];
        end
        
        if (isstruct(dummy_node(index,1).right_child))
            dummy_node = [dummy_node;dummy_node(index,1).right_child];
        elseif (length(dummy_node(index,1).right_child)>1)
             dummy_node = [dummy_node; struct('best_attribute', 0, 'best_threshold',-1,'left_child', 0, 'right_child', 0, 'max_gain',-1)];
        end
        
        index = index+1;   
    end
end

