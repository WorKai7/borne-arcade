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

ACCEL = 0.4
MAX_SPEED = 6
FRICTION = 0.3

vx = 0
vy = 0



def handle_arcade_inputs():
    global vx, vy

    # touches maintenues
    keys = pygame.key.get_pressed()

    # accélération
    if keys[LEFT_KEY]:
        vx -= ACCEL
    if keys[RIGHT_KEY]:
        vx += ACCEL
    if keys[UP_KEY]:
        vy -= ACCEL
    if keys[DOWN_KEY]:
        vy += ACCEL

    # friction (ralentit quand on relâche)
    if not (keys[LEFT_KEY] or keys[RIGHT_KEY]):
        if vx > 0:
            vx = max(0, vx - FRICTION)
        elif vx < 0:
            vx = min(0, vx + FRICTION)

    if not (keys[UP_KEY] or keys[DOWN_KEY]):
        if vy > 0:
            vy = max(0, vy - FRICTION)
        elif vy < 0:
            vy = min(0, vy + FRICTION)

    # limite vitesse
    vx = max(-MAX_SPEED, min(MAX_SPEED, vx))
    vy = max(-MAX_SPEED, min(MAX_SPEED, vy))

    x, y = pygame.mouse.get_pos()

    pygame.mouse.set_pos((x + vx, y + vy))

    for event in pygame.event.get():
        if event.type == pygame.KEYDOWN:
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

def draw_cursor(surface):
    x, y = pygame.mouse.get_pos()
    pygame.draw.circle(surface, (180,180,180,255), (x,y),10)