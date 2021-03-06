// https://github.com/TheGreyGhost/MinecraftByExample

package com.imperialoctopus.meinhaus.blockredstone;

import net.minecraft.block.Block;
import net.minecraft.block.BlockState;
import net.minecraft.entity.LivingEntity;
import net.minecraft.item.BlockItemUseContext;
import net.minecraft.item.ItemStack;
import net.minecraft.util.Direction;
import net.minecraft.util.math.BlockPos;
import net.minecraft.world.IBlockReader;
import net.minecraft.world.World;

import net.minecraft.block.BlockRenderType;
import net.minecraft.block.HorizontalBlock;
import net.minecraft.block.material.Material;

import net.minecraft.state.DirectionProperty;
import net.minecraft.state.IntegerProperty;
import net.minecraft.state.StateContainer;
import net.minecraft.tileentity.TileEntity;
import net.minecraft.util.math.shapes.ISelectionContext;
import net.minecraft.util.math.shapes.VoxelShape;
import net.minecraft.util.math.shapes.VoxelShapes;
import net.minecraft.world.IWorld;



import javax.annotation.Nullable;

public class BlockRedstone extends Block {

    // What are its properties?
    public BlockRedstone(Properties properties) {
        super(properties);
    }

    public BlockRedstone() {

    }

    /**
    * @param world The current world
    * @param blockPos Block position in world of the wire that is trying to connect
    * @param directionFromNeighborToThis if not null: the side of the wire that is trying to make a horizontal connection to this block. If null: test for a stepped connection (i.e. the wire is trying to run up or down the side of solid block in order to connect to this block)
    * @return true if this is a power output for redstone, so that redstone wire should connect to it
    */
    @Override
    public boolean canConnectRedstone(BlockState state, IBlockReader world, BlockPos blockPos, @Nullable Direction directionFromNeighborToThis)
    {
        return false;
    }

    // ---- methods to control placement of the target (must be on a solid wall)
    // copied and adapted from WallSignBlock

    // when the block is placed into the world, calculates the correct BlockState based on which direction the player is looking
    @Nullable
    @Override
    public BlockState getStateForPlacement(BlockItemUseContext context) {
        BlockState blockstate = this.getDefaultState();
        World world = context.getWorld();
        BlockPos blockpos = context.getPos();
        Direction [] nearestLookingDirections = context.getNearestLookingDirections();

        for (Direction direction : nearestLookingDirections) {
            if (direction.getAxis().isHorizontal()) {
                blockstate = blockstate.with(DIRECTION_OF_UNCONNECTED_FACE, direction);
                if (blockstate.isValidPosition(world, blockpos)) {
                    return blockstate;
                }
            }
        }

        return null;
    }

    // ---- methods to handle changes in state and inform neighbours when necessary

    // Called just after the player places a block.
    @Override
    public void onBlockPlacedBy(World worldIn, BlockPos pos, BlockState state, LivingEntity placer, ItemStack stack){
        super.onBlockPlacedBy(worldIn, pos, state, placer, stack);
        BlockState newBlockState = getBlockPowerFromInputs(worldIn, pos, state);
        final int FLAGS = SetBlockStateFlag.get(SetBlockStateFlag.BLOCK_UPDATE, SetBlockStateFlag.SEND_TO_CLIENTS);
        worldIn.setBlockState(pos, newBlockState, FLAGS);
    }







    private BlockState getBlockPowerFromInputs(World worldIn, BlockPos pos, BlockState state) {
    }


}
