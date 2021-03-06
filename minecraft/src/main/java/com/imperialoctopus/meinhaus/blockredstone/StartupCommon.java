package com.imperialoctopus.meinhaus.blockredstone;

import net.minecraft.block.Block;
import net.minecraft.item.BlockItem;
import net.minecraft.item.Item;
import net.minecraft.item.ItemGroup;
import net.minecraftforge.event.RegistryEvent;
import net.minecraftforge.eventbus.api.SubscribeEvent;

public class StartupCommon {

    public static BlockRedstone blockRedstone;
    public static BlockItem itemBlockRedstone;


    @SubscribeEvent
    public static void onBlocksRegistration(final RegistryEvent.Register<Block> blockRegisterEvent) {
        blockRedstone = (BlockRedstone) (new BlockRedstone()
                .setRegistryName("meinhaus", "block_redstone_registry_name")
        );
        blockRegisterEvent.getRegistry().register(blockRedstone);

    }


    @SubscribeEvent
    public static void onItemsRegistration(final RegistryEvent.Register<Item> itemRegisterEvent) {
        final int MAXIMUM_STACK_SIZE = 64;

        Item.Properties itemProperties = new Item.Properties()
                .maxStackSize(MAXIMUM_STACK_SIZE)
                .group(ItemGroup.REDSTONE);
        itemBlockRedstone = new BlockItem(blockRedstone, itemProperties);
        itemBlockRedstone.setRegistryName(blockRedstone.getRegistryName());
        itemRegisterEvent.getRegistry().register(itemBlockRedstone);
    }
}
