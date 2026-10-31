package net.lostlegion.sol;

import net.runelite.client.config.Config;
import net.runelite.client.config.ConfigGroup;
import net.runelite.client.config.ConfigItem;

@ConfigGroup(SolConfig.GROUP)
public interface SolConfig extends Config
{
    String GROUP = "lostlegionsol";

    @ConfigItem(
        keyName = "greeting",
        name = "Welcome Greeting",
        description = "The message to show to the user when they login"
    )
    default String greeting()
    {
        return "Hello";
    }
}
