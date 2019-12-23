function plotComponents(I, er, cr, eb, cb)
    components = getAll(er, cr, eb, cb);
    L = length(components);

    f = figure;
    for num = 1:L 
        comp = components(num);
        cutI = I(comp.up : comp.down, comp.left : comp.right, :);
        subplot(1, L, num);
        imshow(cutI);
    end
end

function all = getAll(er, cr, eb, cb)
    all = [];
    if er
        all = [all, cr];
    end
    if eb
        all = [all, cb];
    end
end