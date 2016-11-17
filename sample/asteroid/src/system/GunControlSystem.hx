package system;

import ecs.Engine;
import ecs.Node;
import ecs.System;
import node.Nodes;
import util.*;

using tink.CoreApi;

class GunControlSystem extends NodeListSystem<GunControlNode> {
	var input:Input;
	
	public function new(input) {
		super();
		this.input = input;
	}
	
	override function updateNode(node:GunControlNode, dt:Float) {
		var control = node.gunControls;
		var position = node.position;
		var gun = node.gun;
		
		var triggered = input.isDown(control.trigger);
		gun.elapsed += dt;
		if(triggered && gun.elapsed > gun.interval) {
			engine.addEntity(new entity.Bullet(gun, position));
			gun.elapsed = 0;
		}
	}
}