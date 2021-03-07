package com.imperialoctopus.freshstart;

import net.minecraft.block.Block;
import net.minecraft.block.BlockState;
import net.minecraft.client.Minecraft;
import net.minecraft.item.BlockItemUseContext;
import net.minecraft.util.Direction;
import net.minecraft.util.math.BlockPos;
import net.minecraft.world.IWorldReader;
import net.minecraft.world.World;
import net.minecraft.world.server.ServerWorld;

import java.util.Random;

public class SpecialBlock extends Block {

    private static final Direction DOWN = Direction.DOWN;
    private static final Direction WEST = Direction.WEST;
    private static final Direction EAST = Direction.EAST;
    private static final Direction NORTH = Direction.NORTH;
    private static final Direction SOUTH = Direction.SOUTH;

    public SpecialBlock(Properties properties) {
        super(properties);
    }


    private static boolean isPowered(World world, BlockPos pos) {
        boolean powered = world.isBlockPowered(pos);
        return powered;
    }

    private int getPowerLevelInputFromNeighbours(World world, BlockPos pos) {

//    int powerLevel = world.getRedstonePowerFromNeighbors(pos);  // if input can come from any side, use this line

        int maxPowerFound = 0;
        Direction[] directions = new Direction[]{DOWN, WEST, EAST, NORTH, SOUTH};

        for (Direction whichFace : directions) {
            BlockPos neighborPos = pos.offset(whichFace);
            int powerLevel = world.getRedstonePower(neighborPos, whichFace);
            maxPowerFound = Math.max(powerLevel, maxPowerFound);
        }

        return maxPowerFound;
    }

    @Override
    public void tick(BlockState state, ServerWorld world, BlockPos pos, Random rand) {
        if (isPowered(world, pos)) {
            LOGGER.info("Hello WOrld");
            LOGGER.log(LOGGER.getLevel(), "TEST");
            return;
        }
        else {
            world.getPendingBlockTicks().scheduleTick(pos, this, this.tickRate(world));
        }


    }

    /**
     * How often should we tick this block?
     */
    public int tickRate(IWorldReader worldIn) {
        final int TICKS_PER_SECOND = 20;
        final int TICK_PERIOD_IN_SECONDS = 1;
        return TICK_PERIOD_IN_SECONDS * TICKS_PER_SECOND;
    }
}
