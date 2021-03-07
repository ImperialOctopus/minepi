// https://github.com/TheGreyGhost/MinecraftByExample

package com.imperialoctopus.meinhaus.blockredstone;
import com.imperialoctopus.meinhaus.SetBlockStateFlag;

import net.minecraft.block.*;
import net.minecraft.client.Minecraft;
import net.minecraft.entity.LivingEntity;
//import net.minecraft.entity.player.EntityPlayer;
import net.minecraft.item.BlockItemUseContext;
import net.minecraft.item.ItemStack;
import net.minecraft.util.Direction;
import net.minecraft.util.math.BlockPos;
import net.minecraft.util.text.TranslationTextComponent;
import net.minecraft.world.IBlockReader;
import net.minecraft.world.World;

import net.minecraft.block.material.Material;

import net.minecraft.state.DirectionProperty;
import net.minecraft.state.IntegerProperty;
import net.minecraft.state.StateContainer;
import net.minecraft.tileentity.TileEntity;
import net.minecraft.util.math.shapes.ISelectionContext;
import net.minecraft.util.math.shapes.VoxelShape;
import net.minecraft.util.math.shapes.VoxelShapes;
import net.minecraft.world.IWorld;
import net.minecraftforge.client.event.ClientChatEvent;


import javax.annotation.Nullable;
import java.awt.*;

public class BlockRedstone extends Block {

    private static final Direction DOWN = Direction.DOWN;
    private static final Direction WEST = Direction.WEST;
    private static final Direction EAST = Direction.EAST;
    private static final Direction NORTH = Direction.NORTH;
    private static final Direction SOUTH = Direction.SOUTH;

    // What are its properties?
    public BlockRedstone(Properties properties) {
        super(properties);
    }

    public BlockRedstone() {
        super(Block.Properties
                .create(Material.IRON)
                .hardnessAndResistance(0.5f, 1.0f)
                .sound(SoundType.GLASS)
        );
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

    // Checks if state changes after a neighbour has their state updated
    @Override
    public void neighborChanged(BlockState currentState, World worldIn, BlockPos pos, Block blockIn, BlockPos fromPos, boolean isMoving) {
        BlockState newBlockState = getBlockPowerFromInputs(worldIn, pos, currentState);
        if (newBlockState != currentState) {
            final int FLAGS = SetBlockStateFlag.get(SetBlockStateFlag.BLOCK_UPDATE, SetBlockStateFlag.SEND_TO_CLIENTS);
            worldIn.setBlockState(pos, newBlockState, FLAGS);
        }
    }

    @Override
    public VoxelShape getShape(BlockState state, IBlockReader worldIn, BlockPos pos, ISelectionContext context) {
        return VoxelShapes.fullCube();
    }



    private int getPowerLevelInputFromNeighbours(World world, BlockPos pos) {

//    int powerLevel = world.getRedstonePowerFromNeighbors(pos);  // if input can come from any side, use this line

        int maxPowerFound = 0;
        Direction [] directions = new Direction[]{DOWN, WEST, EAST, NORTH, SOUTH};

        for (Direction whichFace : directions) {
            BlockPos neighborPos = pos.offset(whichFace);
            int powerLevel = world.getRedstonePower(neighborPos, whichFace);
            maxPowerFound = Math.max(powerLevel, maxPowerFound);
        }

        return maxPowerFound;
    }


    private void calculatePowerInput(World world, BlockPos pos) {
        int powerLevel = getPowerLevelInputFromNeighbours(world, pos);

    }

    private static boolean blockPower(World world, BlockPos pos) {
        boolean powered = world.isBlockPowered(pos);

        return powered;
    }

    @SubscribeEvent
    public void chatMessage(ClientChatEvent event) {

    }


    private BlockState getBlockPowerFromInputs(World worldIn, BlockPos pos, BlockState state) {



        Direction north = Direction.NORTH;
        Direction east = Direction.EAST;
        Direction south = Direction.SOUTH;
        Direction west = Direction.WEST;

        BlockPos northNeighbour = pos.offset(north);
        BlockPos eastNeighbour = pos.offset(east);
        BlockPos southNeighbour = pos.offset(south);
        BlockPos westNeighbour = pos.offset(west);

        int northPower = worldIn.getRedstonePower(northNeighbour, north);
        int eastPower = worldIn.getRedstonePower(eastNeighbour, east);
        int southPower = worldIn.getRedstonePower(southNeighbour, south);
        int westPower = worldIn.getRedstonePower(westNeighbour, west);

        final int MIN_POWER_INPUT = 0;
        final int MAX_POWER_OUTPUT = 15;

        BlockState newBlockState = state
                .with(pow)
    }


}
