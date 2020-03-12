function out = GetDCT(Frame)
    const = Constants();
    [rows, columns] = size(Frame); 
    DCT = int32(Frame); % Convert to 32 bit

    % Init interval variables when working with blocksizeXblocksize
    Row_MaxInterval = const.BlockSize;
    Column_MaxInterval = const.BlockSize;
    
    for Row_MinInterval = 1:const.BlockSize:rows % sweeping rows
        if(Row_MaxInterval > rows) 
            break; % Nothing left in the photo to sweep
        end % Bounding since I am inc by Blocksize
        
        for Column_MinInterval = 1:const.BlockSize:columns % Sweeping columns
            if (Column_MaxInterval > columns) 
                Column_MaxInterval = const.BlockSize; % reset
            end % Bounding since I am inc by Blocksize

            % Getting DCT Block [DCTImage[Block] <= DCTBlock]
            Block = GetDCTBlock(int32(Frame(Row_MinInterval:Row_MaxInterval,Column_MinInterval:Column_MaxInterval)));
            DCT(Row_MinInterval:Row_MaxInterval,Column_MinInterval:Column_MaxInterval) = Block;

            % Increment Column Block
            Column_MaxInterval = Column_MaxInterval + const.BlockSize; % bound this
        end

        % Increment Row Block
        Row_MaxInterval = Row_MaxInterval + const.BlockSize; % bound this
    end

    out = DCT;
end


function out = GetDCTBlock(PixelBlock) %Pixel is already 32 bit
    [rows, columns] = size(PixelBlock);
    DCTOutput = PixelBlock; % declare, ensures same type and size
    for m = 0:rows-1
        for n = 0:columns-1
            DCTOutput(m+1,n+1) = GetDCTCoefficient(cm_cn_handler(m,n),PixelBlock);
        end
    end
    out = DCTOutput;
end

function out = GetDCTCoefficient(var,pixel)
    [M, N] = size(pixel);

    % Calculate the inner loop of DCT
    Loop = int32(0);
    for i = 0:(M-1)
        for j = 0:(N-1)
            part1 = cos(((2*i + 1)*var.m*pi)/(2*M));
            part2 = cos(((2*j + 1)*var.n*pi)/(2*N));
            pix = pixel(i+1, j+1, :); % Index pixel
            Loop = Loop + int32(pix * part1 * part2);
        end
    end
    out = (2/sqrt(M*N)) * var.cm * var.cn * Loop;
end

