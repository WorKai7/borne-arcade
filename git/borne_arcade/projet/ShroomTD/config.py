import pygame

# === Contrôles ===
# Mappage des touches de jeu

ESCAPE_KEY = pygame.K_f # remplacement de echap
UP_KEY = pygame.K_UP #joystick vers le haut
DOWN_KEY = pygame.K_DOWN #joystick vers le bas 
LEFT_KEY = pygame.K_LEFT #joystick vers la gauche
RIGHT_KEY = pygame.K_RIGHT #joystick vers la droite
CONFIRM_KEY = pygame.K_g #remplacement de clic gauche
DESELECT_KEY = pygame.K_h #remplacement de clic droit

def handle_arcade_inputs():


    for event in pygame.event.get():
        if event.type == pygame.KEYDOWN:
            if event.key == UP_KEY:
                position = pygame.mouse.get_pos()
                pygame.mouse.set_pos([position[0],position[1]-1])
            if event.key == DOWN_KEY:
                position = pygame.mouse.get_pos()
                pygame.mouse.set_pos([position[0],position[1]+1])
            if event.key == LEFT_KEY:
                position = pygame.mouse.get_pos()
                pygame.mouse.set_pos([position[0]-1,position[1]])
            if event.key == RIGHT_KEY:
                position = pygame.mouse.get_pos()
                pygame.mouse.set_pos([position[0]+1,position[1]])
            if event.key == CONFIRM_KEY:
                fake_event = pygame.event.Event(
                    pygame.MOUSEBUTTONDOWN,
                    {"button": 1, "pos": pygame.mouse.get_pos()}
                    )
                pygame.event.post(fake_event)
            if event.key == DESELECT_KEY:
                fake_event = pygame.event.Event(
                    pygame.MOUSEBUTTONDOWN,
                    {"button": 3, "pos": pygame.mouse.get_pos()}
                    )
                pygame.event.post(fake_event)
            if event.key == ESCAPE_KEY:
                fake_event = pygame.event.Event(
                pygame.KEYDOWN,
                {"key": pygame.K_ESCAPE}
                )
                pygame.event.post(fake_event)



