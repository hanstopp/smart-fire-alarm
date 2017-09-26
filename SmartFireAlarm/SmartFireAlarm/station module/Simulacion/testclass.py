import httpModule as http,pygame,time,random as ra
from pygame.locals import *
from config import *

WIDTH = 400
HEIGHT = 300

def texto(texto, posx, posy, color=(255, 255, 255)):
    fuente = pygame.font.Font("ttf/DroidSans.ttf", 30)
    salida = pygame.font.Font.render(fuente, texto, 1, color)
    salida_rect = salida.get_rect()
    salida_rect.centerx = posx
    salida_rect.centery = posy
    return salida, salida_rect

def main():
    screen = pygame.display.set_mode((WIDTH, HEIGHT))
    pygame.display.set_caption("Simulador de dispositivo")
    scr_rect = screen.get_rect()
    btn_rect = pygame.Rect(100,100,200,100)
    index = ''
    cnx1 = http.Http(HOST,PORT)
    lok = True
    params = {
        'mcu_action':'set_credential',
        'ssid':'wifi_uctemuco_libre'
    }                   
    response = cnx1.post(index, params)
    print response
    while lok:
        for event in pygame.event.get():
            if event.type == QUIT:

                lok = False
            if event.type == MOUSEBUTTONUP:
                mousex, mousey = event.pos
                if btn_rect.left < mousex and mousex < btn_rect.right and btn_rect.top < mousey and mousey < btn_rect.bottom:
                #----------------funcionamiento principal------------------------------
                    params = {
                        'mcu_action':'get_adc'
                    }
                    response = cnx1.post(index, params)
                    print response
                    params = {
                        'mcu_action':'get_ip'
                    }
                    response = cnx1.post(index, params)
                    print response
                    if "Value" in response:
                        params = {
                            'srv_action':'set_user',
                            'user':'aflores',
                            'pwd':'12345678'
                        }
                        response = cnx1.post(index, params)
                        print response
                #--------------------------------------------------------------
        pygame.draw.rect(screen,pygame.Color(200,200,200,255),scr_rect)
        pygame.draw.rect(screen,pygame.Color(150,150,150,255),btn_rect)
        btn_str,btn_rct = texto("POST", btn_rect.centerx, btn_rect.centery)
        screen.blit(btn_str,btn_rct)
        pygame.display.flip()
    return 0

if __name__ == '__main__':
    pygame.init()
    main()