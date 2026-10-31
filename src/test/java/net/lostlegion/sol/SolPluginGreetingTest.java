package net.lostlegion.sol;

import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.verifyNoInteractions;
import static org.mockito.Mockito.when;

import com.google.inject.Guice;
import com.google.inject.testing.fieldbinder.Bind;
import com.google.inject.testing.fieldbinder.BoundFieldModule;
import javax.inject.Inject;
import net.runelite.api.ChatMessageType;
import net.runelite.api.Client;
import net.runelite.api.GameState;
import net.runelite.api.events.GameStateChanged;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.Mock;
import org.mockito.junit.MockitoJUnitRunner;

@RunWith(MockitoJUnitRunner.class)
public class SolPluginGreetingTest
{
    @Mock
    @Bind
    private Client client;

    @Mock
    @Bind
    private SolConfig config;

    @Inject
    private SolPlugin plugin;

    @Before
    public void before()
    {
        Guice.createInjector(BoundFieldModule.of(this)).injectMembers(this);
    }

    @Test
    public void greetsOnLogin()
    {
        when(config.greeting()).thenReturn("Hello");

        plugin.onGameStateChanged(gameState(GameState.LOGGED_IN));

        verify(client).addChatMessage(ChatMessageType.GAMEMESSAGE, "", "Sol says Hello", null);
    }

    @Test
    public void staysSilentOnLoginScreen()
    {
        plugin.onGameStateChanged(gameState(GameState.LOGIN_SCREEN));

        verifyNoInteractions(client);
    }

    private static GameStateChanged gameState(GameState state)
    {
        GameStateChanged event = new GameStateChanged();
        event.setGameState(state);
        return event;
    }
}
