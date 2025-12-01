classdef NodeObj
    properties
        id
        x
        y
        shape = 'o'
        color = [0 0 1]
    end

    methods
        function obj = NodeObj(id, x, y, shape, color)
            obj.id = id;
            obj.x = x;
            obj.y = y;
            obj.shape = shape;
            obj.color = color;
        end
    end
end
