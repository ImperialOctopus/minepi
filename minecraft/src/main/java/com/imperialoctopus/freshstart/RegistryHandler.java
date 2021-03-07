package com.imperialoctopus.freshstart;

import net.minecraft.block.Block;
import net.minecraft.block.SoundType;
import net.minecraft.block.material.Material;
import net.minecraft.item.BlockItem;
import net.minecraft.item.Item;
import net.minecraft.item.ItemGroup;
import net.minecraftforge.fml.RegistryObject;
import net.minecraftforge.fml.javafmlmod.FMLJavaModLoadingContext;
import net.minecraftforge.registries.DeferredRegister;
import net.minecraftforge.registries.ForgeRegistries;

public class RegistryHandler {
        // create DeferredRegister objects
        public static final DeferredRegister<Block> BLOCKS = DeferredRegister.create(ForgeRegistries.BLOCKS,
                        FreshStart.MODID);
        public static final DeferredRegister<Item> ITEMS = DeferredRegister.create(ForgeRegistries.ITEMS,
                        FreshStart.MODID);

        public static void init() {
                // attach DeferredRegister to the event bus
                BLOCKS.register(FMLJavaModLoadingContext.get().getModEventBus());
                ITEMS.register(FMLJavaModLoadingContext.get().getModEventBus());
        }

        // register blocks
        public static final RegistryObject<SpecialBlock> RED_BLOCK = BLOCKS.register("pi_block_red",
                        () -> new SpecialBlock("red", (SpecialBlock.Properties.create(Material.IRON)
                                        .hardnessAndResistance(2.0f, 10.0f).sound(SoundType.GLASS))));

        public static final RegistryObject<SpecialBlock> GREEN_BLOCK = BLOCKS.register("pi_block_green",
                        () -> new SpecialBlock("green", (SpecialBlock.Properties.create(Material.IRON)
                                        .hardnessAndResistance(2.0f, 10.0f).sound(SoundType.GLASS))));

        public static final RegistryObject<SpecialBlock> YELLOW_BLOCK = BLOCKS.register("pi_block_yellow",
                        () -> new SpecialBlock("yellow", (SpecialBlock.Properties.create(Material.IRON)
                                        .hardnessAndResistance(2.0f, 10.0f).sound(SoundType.GLASS))));

        // register items
        public static final RegistryObject<Item> RED_BLOCK_ITEM = ITEMS.register("pi_block_red",
                        () -> new BlockItem(RED_BLOCK.get(), new Item.Properties().group(ItemGroup.REDSTONE)));

        public static final RegistryObject<Item> GREEN_BLOCK_ITEM = ITEMS.register("pi_block_green",
                        () -> new BlockItem(GREEN_BLOCK.get(), new Item.Properties().group(ItemGroup.REDSTONE)));

        public static final RegistryObject<Item> YELLOW_BLOCK_ITEM = ITEMS.register("pi_block_yellow",
                        () -> new BlockItem(YELLOW_BLOCK.get(), new Item.Properties().group(ItemGroup.REDSTONE)));

}
