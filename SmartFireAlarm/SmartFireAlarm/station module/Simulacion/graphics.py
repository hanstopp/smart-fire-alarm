import pygame,json
from pygame.locals import *

# Constantes
WIDTH = 640
HEIGHT = 480

# Funciones -----------------------------------------------------------

def load_image(filename, transparent=False):
    try: image = pygame.image.load(filename)
    except pygame.error, message:
        raise SystemExit, message
    image = image.convert()
    if transparent:
        color = image.get_at((0, 0))
        image.set_colorkey(color, RLEACCEL)
    return image

def text(text, posx, posy, color=(255, 255, 255),size=12,align='center'):
    font = pygame.font.SysFont("comicsansms", size)
    out = pygame.font.Font.render(font, text, 1, color)
    rect = out.get_rect()
    if align=="topleft":
        rect.left = posx
        rect.top = posy
    else:
        rect.centerx = posx
        rect.centery = posy
    return out, rect

class Panel():

    def __init__(self):
        # image
        self.image = pygame.Surface((WIDTH,HEIGHT))
        self.image.fill((200,200,200))

        # get_adc_image
        self.get_adc_image = pygame.Surface((100,30))
        self.get_adc_image.fill((100,100,100))
        ti, tr = text("get_adc",50,15)
        self.get_adc_image.blit(ti,tr)
        self.get_adc_rect = self.get_adc_image.get_rect()
        self.get_adc_rect.center = (75,40)

        # set_user_image
        self.set_user_image = pygame.Surface((100,30))
        self.set_user_image.fill((100,100,100))
        ti, tr = text("set_user",50,15)
        self.set_user_image.blit(ti,tr)
        self.set_user_rect = self.set_user_image.get_rect()
        self.set_user_rect.center = (275,40)

        # get_ip_image
        self.get_ip_image = pygame.Surface((100,30))
        self.get_ip_image.fill((100,100,100))
        ti, tr = text("get_ip",50,15)
        self.get_ip_image.blit(ti,tr)
        self.get_ip_rect = self.get_ip_image.get_rect()
        self.get_ip_rect.center = (75,100)

        # get_networks_image
        self.get_networks_image = pygame.Surface((100,30))
        self.get_networks_image.fill((100,100,100))
        ti, tr = text("get_networks",50,15)
        self.get_networks_image.blit(ti,tr)
        self.get_networks_rect = self.get_networks_image.get_rect()
        self.get_networks_rect.center = (75,160)

        # set_credential
        self.set_credential_image = pygame.Surface((100,30))
        self.set_credential_image.fill((100,100,100))
        ti, tr = text("set_credential",50,15)
        self.set_credential_image.blit(ti,tr)
        self.set_credential_rect = self.set_credential_image.get_rect()
        self.set_credential_rect.center = (75,220)

        # update
        self.update_image = pygame.Surface((100,30))
        self.update_image.fill((0,255,0))
        ti, tr = text("Update",50,15)
        self.update_image.blit(ti,tr)
        self.update_rect = self.update_image.get_rect()
        self.update_rect.center = (75,280)

        self.image.blit(self.get_adc_image,self.get_adc_rect)
        self.image.blit(self.set_user_image,self.set_user_rect)
        self.image.blit(self.get_ip_image,self.get_ip_rect)
        self.image.blit(self.get_networks_image,self.get_networks_rect)
        self.image.blit(self.set_credential_image,self.set_credential_rect)
        self.image.blit(self.update_image,self.update_rect)
        try:
            f = open("credential.json")
            self.credential = f.read()
            f.close()
        except Exception:
            self.credential = '{}'
        i = 0
        for line in self.credential.split("\n"):
            ti, tr = text(line,30,15*i+315,align="topleft")
            self.image.blit(ti,tr)
            i += 1
        self.credential = json.loads(self.credential.replace('\n','').replace(' ',''))

    def update(self):
        self.image.fill((200,200,200))
        self.image.blit(self.get_adc_image,self.get_adc_rect)
        self.image.blit(self.set_user_image,self.set_user_rect)
        self.image.blit(self.get_ip_image,self.get_ip_rect)
        self.image.blit(self.get_networks_image,self.get_networks_rect)
        self.image.blit(self.set_credential_image,self.set_credential_rect)
        self.image.blit(self.update_image,self.update_rect)
        try:
            f = open("credential.json")
            self.credential = f.read()
            f.close()
        except Exception:
            self.credential = '{}'
        i = 0
        for line in self.credential.split("\n"):
            ti, tr = text(line,30,15*i+315,align="topleft")
            self.image.blit(ti,tr)
            i += 1
        self.credential = json.loads(self.credential.replace('\n','').replace(' ',''))
