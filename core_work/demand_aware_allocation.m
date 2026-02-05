function alloc_table = demand_aware_allocation(free_bands,demand,cap)
    free_bands  = sortrows(free_bands, 1);
    alloc_table = [];

    demand_copy = demand(:).';     
    SU_count    = length(demand_copy);

    rounds = 50;    
    idx    = 1;     

    % ---------- Allocation Loop ----------
    for r = 1:rounds
        if isempty(free_bands) || all(demand_copy <= 0)
            break;
        end
        if demand_copy(idx) <= 0
            idx = mod(idx, SU_count) + 1;
            continue;
        end
        for b = 1:size(free_bands, 1)

            start_point = free_bands(b,1);
            end_point   = free_bands(b,2);
            width       = end_point - start_point;

           
            alloc_bw = min(demand_copy(idx), width - cap);

            if alloc_bw > 0
                alloc_start = start_point + cap/2;
                alloc_end   = alloc_start + alloc_bw;
                alloc_table = [alloc_table; ...
                    idx, alloc_start, alloc_end, alloc_bw];

                demand_copy(idx) = demand_copy(idx) - alloc_bw;

                new_blocks = [];

             
                if alloc_start - cap/2 > start_point
                    new_blocks = [new_blocks; ...
                        start_point, alloc_start - cap/2];
                end

                
                if end_point > alloc_end + cap/2
                    new_blocks = [new_blocks; ...
                        alloc_end + cap/2, end_point];
                end

                free_bands = [ ...
                    free_bands(1:b-1, :); ...
                    new_blocks; ...
                    free_bands(b+1:end, :) ];

                free_bands = sortrows(free_bands, 1);
                break;  
            end
        end
        idx = mod(idx, SU_count) + 1;
    end
end
