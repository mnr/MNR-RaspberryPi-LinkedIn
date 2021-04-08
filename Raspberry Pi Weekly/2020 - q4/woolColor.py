from mcpi import minecraft, block, vec3
from time import sleep

mc = minecraft.Minecraft.create()

ImHere = mc.player.getPos() # get current player position

for woolColor in range(15):
    blockPosition = vec3.Vec3(ImHere.x-2, ImHere.y, ImHere.z)
    mc.setBlock(blockPosition, block.WOOL.id, woolColor)
    sleep(1)
    