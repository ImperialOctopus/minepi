package com.imperialoctopus.freshstart;

import javax.annotation.Nullable;

import com.imperialoctopus.extension.SetBlockStateFlag;

import net.minecraft.block.Block;
import net.minecraft.block.BlockState;
import net.minecraft.entity.LivingEntity;
import net.minecraft.item.BlockItemUseContext;
import net.minecraft.item.ItemStack;
import net.minecraft.util.Direction;
import net.minecraft.util.math.BlockPos;
import net.minecraft.world.IBlockReader;
import net.minecraft.world.World;
import net.minecraft.state.IntegerProperty;
import net.minecraft.state.StateContainer;
import net.minecraft.util.math.shapes.ISelectionContext;
import net.minecraft.util.math.shapes.VoxelShape;
import net.minecraft.util.math.shapes.VoxelShapes;

public class SpecialBlock extends Block {

    /**
     * private static final Direction DOWN = Direction.DOWN; private static final
     * Direction WEST = Direction.WEST; private static final Direction EAST =
     * Direction.EAST; private static final Direction NORTH = Direction.NORTH;
     * private static final Direction SOUTH = Direction.SOUTH;
     */

    public SpecialBlock(Properties properties) {
        super(properties);
    }

    /**
     * Determine if this block will provide power to redstone and can make a
     * redstone connection on the side provided. Useful to control which sides are
     * outputs for redstone wires.
     *
     * Don't use for inputs; for redstone which is just "passing by", it will make
     * the redstone connect to the side of the block but it won't actually inject
     * weak power into the block.
     *
     * @param world                       The current world
     * @param blockPos                    Block position in world of the wire that
     *                                    is trying to connect
     * @param directionFromNeighborToThis if not null: the side of the wire that is
     *                                    trying to make a horizontal connection to
     *                                    this block. If null: test for a stepped
     *                                    connection (i.e. the wire is trying to run
     *                                    up or down the side of solid block in
     *                                    order to connect to this block)
     * @return true if this is a power output for redstone, so that redstone wire
     *         should connect to it
     */
    @Override
    public boolean canConnectRedstone(BlockState state, IBlockReader world, BlockPos blockPos,
            @Nullable Direction directionFromNeighborToThis) {
        return false;
    }

    // when the block is placed into the world, calculates the correct BlockState
    // based on which direction the player is looking
    // Don't worry about the lamp colour yet, that's handled in onBlockPlacedBy()
    @Nullable
    @Override
    public BlockState getStateForPlacement(BlockItemUseContext context) {
        return this.getDefaultState();
    }

    // ---- methods to handle changes in state and inform neighbours when necessary

    // Called just after the player places a block. Sets the lamp's colour.
    @Override
    public void onBlockPlacedBy(World worldIn, BlockPos pos, BlockState state, LivingEntity placer, ItemStack stack) {
        super.onBlockPlacedBy(worldIn, pos, state, placer, stack);
        BlockState newBlockState = getBlockStateFromInputs(worldIn, pos, state);
        final int FLAGS = SetBlockStateFlag.get(SetBlockStateFlag.BLOCK_UPDATE, SetBlockStateFlag.SEND_TO_CLIENTS);
        worldIn.setBlockState(pos, newBlockState, FLAGS);
    }

    /**
     * A neighbour has updated their state. Check if redstone strength inputs have
     * changed
     */
    @Override
    public void neighborChanged(BlockState currentState, World worldIn, BlockPos pos, Block blockIn, BlockPos fromPos,
            boolean isMoving) {
        BlockState newBlockState = getBlockStateFromInputs(worldIn, pos, currentState);
        if (newBlockState != currentState) {
            final int FLAGS = SetBlockStateFlag.get(SetBlockStateFlag.BLOCK_UPDATE, SetBlockStateFlag.SEND_TO_CLIENTS);
            worldIn.setBlockState(pos, newBlockState, FLAGS);
        }
    }

    // ----- methods related to the block's appearance (see MBE01_BLOCK_SIMPLE and
    // MBE02_BLOCK_PARTIAL)

    @Override
    public VoxelShape getShape(BlockState state, IBlockReader worldIn, BlockPos pos, ISelectionContext context) {
        return VoxelShapes.fullCube();
    }

    // ---------methods related to storing information about the block (which way
    // it's facing, the power level)

    private static final int MIN_POWER = 0;
    private static final int MAX_POWER = 15;
    private static final IntegerProperty POWER_LEVEL = IntegerProperty.create("power_level", MIN_POWER, MAX_POWER);

    // necessary to define which properties your block use - will also affect the
    // variants listed in the blockstates model file
    protected void fillStateContainer(StateContainer.Builder<Block, BlockState> builder) {
        builder.add(POWER_LEVEL);
    }

    /**
     * Read the redstone inputs on the red, green, and blue input faces and return
     * the corresponding blockstate
     * 
     * @param world
     * @param pos
     * @param state
     * @return
     */
    private BlockState getBlockStateFromInputs(World world, BlockPos pos, BlockState state) {
        // the colour is based on the redstone inputs from three sides.
        // If the lamp is facing NORTH, the red input is WEST, green input is SOUTH,
        // blue input is EAST

        final int power = world.getRedstonePowerFromNeighbors(pos);

        BlockState newBlockState = state.with(POWER_LEVEL, (int) power);

        System.out.println(power);

        return newBlockState;
    }
}
