function plotComponents(I, er, ct, eb, cb)
    components = getAll(er, cr, eb, cb);
    L = length(components);

    figure; subolot(2, L, 1); imshow(I);
    for num = 1:L 
        comp = components(num);
        cutI = I(comp.up : comp.down, comp.left : comp.right);
        subplot(2, L, L + num);
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