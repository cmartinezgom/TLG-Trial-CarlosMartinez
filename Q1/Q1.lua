-- Technical Trial Task for Tavernlight Games Software Developer role
-- by Carlos Martínez

-- Q1 - Fix or improve the implementation of the below methods

-- 1- I have tabulated the code appropriately to increase readability.
-- 2- I have checked if every name is self-explanatory and follows the camelCase convention (for variables) or PascalCase convention (for functions). I am assuming this convention in also followed by the rest of the code.
-- 3- I have added a check to ensure that the player object exists in both functions. Assuming anything that a function receives exists is a bad code practice.

-- First function
-- 1- I don't have enough context to know exactly how these functions work, but I am assuming the first one is used to "release" a specific storage slot, as the name sugests a general use.
--    So if that's the case, it's better to have the storage index as a parameter. If it's a specific number for a reason, then I would have changed the function's name and probably add
--    a global constant to avoid magic numbers.
-- 2- Similar to the previous point, if the intention of the function is to empty a certain slot of the storage system, if feels more natural to set it to 0 and change the name to EmptyPlayerStorageSlot.
--    Again, maybe that's not how the function should work and "release" means literally getting rid of a entire storage/storage slot.
-- 3- I have deleted the 'local' keyword because I think a function meant to release a storage slot from any player should be called from wherever the game may need it.

-- Second function
-- 1- Again, I don't exactly know how the storage system works, so I am assuming what feels more natural: a set of slots that have an amount related to them. So if when a player log outs we are emptying
--    their storage, we should empty all their storage.
-- 2- Because of the previous statement, I have created a "EmptyPlayerStorage" function that uses "EmptyPlayerStorageSlot", as it could be useful in other scenarios. It would need a function that gets the storage
--    or the storage size to propperly work, but that's trivial to implement if needed.

-- function that empties a storage slot from a player
function EmptyPlayerStorageSlot(player, storageIndex)
    -- check if the player is valid
    if player then
        -- empty the storage at storageIndex for the valid player by setting its value to 0
        player:SetStorageValue(storageIndex, 0)
    end
end

-- function that empties the full storage of a player
local function EmptyPlayerStorage(player)
    if player then
        -- go through the storage
        for i = 0, player:GetStorageSize() - 1 do
            -- check which slots have items on them
            if player:GetStorageValue(i) > 0 then
                -- if a slot has items, empty it
                player:EmptyPlayerStorageSlot(player, i)
            end
        end
    end
end


-- function called when a player logs out
function OnLogout(player)
    -- check if the player is valid
    if player then
        -- trigger EmptyPlayerStorage from the player in 1000 (ms?)
        AddEvent(EmptyPlayerStorage, 1000, player)
        -- log out has been successful
        return true
    else
        -- log out has been unsuccessful
        return false
    end
end