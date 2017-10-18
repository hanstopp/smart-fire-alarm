import httpModule as http,pygame,time,random as ra
from pygame.locals import *
from config import *
from graphics import *

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

    panel = Panel()

    index = ''
    cnx1 = http.Http(HOST,PORT)
    lok = True
    while lok:
        for event in pygame.event.get():
            if event.type == QUIT:

                lok = False
            if event.type == MOUSEBUTTONUP:
                x, y = event.pos
                #----------------funcionamiento principal----------------
                if panel.get_adc_rect.left <= x and x <= panel.get_adc_rect.right and panel.get_adc_rect.top <= y and y <= panel.get_adc_rect.bottom:
                    params = {
                        'mcu_action':'get_adc'
                    }
                    response = cnx1.post(index, params)
                    print response
                elif panel.get_ip_rect.left <= x and x <= panel.get_ip_rect.right and panel.get_ip_rect.top <= y and y <= panel.get_ip_rect.bottom:
                    params = {
                        'mcu_action':'get_ip'
                    }
                    response = cnx1.post(index, params)
                    print response
                elif panel.get_networks_rect.left <= x and x <= panel.get_networks_rect.right and panel.get_networks_rect.top <= y and y <= panel.get_networks_rect.bottom:
                    params = {
                        'mcu_action':'get_networks'
                    }
                    response = cnx1.post(index, params)
                    print response
                elif panel.set_credential_rect.left <= x and x <= panel.set_credential_rect.right and panel.set_credential_rect.top <= y and y <= panel.set_credential_rect.bottom:
                    params = panel.credential
                    response = cnx1.post(index, params)
                    print response
                elif panel.update_rect.left <= x and x <= panel.update_rect.right and panel.update_rect.top <= y and y <= panel.update_rect.bottom:
                    panel.update()
                elif panel.set_user_rect.left <= x and x <= panel.set_user_rect.right and panel.set_user_rect.top <= y and y <= panel.set_user_rect.bottom:
                    params = {
                        'srv_action':'set_user',
                        'user':'aflores',
                        'pwd':'12345678'
                    }
                    response = cnx1.post(index, params)
                    print response
                #--------------------------------------------------------
        screen.blit(panel.image,(0,0))
        pygame.display.flip()
    return 0

if __name__ == '__main__':
    pygame.init()
    main()
