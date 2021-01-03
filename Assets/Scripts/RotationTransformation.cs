﻿//=========================================
//Author: 洪金敏
//Email: jonny.hong91@gmail.com
//Create Date: 2021-01-03 14:26:19
//Description: 
//=========================================

using UnityEngine;

public class RotationTransformation : Transformation
{
	public Vector3 Rotation;

	public override Matrix4x4 Matrix
	{
		get
		{
			var radX = Rotation.x * Mathf.Deg2Rad;
			var radY = Rotation.y * Mathf.Deg2Rad;
			var radZ = Rotation.z * Mathf.Deg2Rad;
			var sinX = Mathf.Sin(radX);
			var cosX = Mathf.Cos(radX);
			var sinY = Mathf.Sin(radY);
			var cosY = Mathf.Cos(radY);
			var sinZ = Mathf.Sin(radZ);
			var cosZ = Mathf.Cos(radZ);

			var matrix = new Matrix4x4();
			matrix.SetColumn(0, new Vector4(
				cosY * cosZ,
				cosX * sinZ + sinX * sinY * cosZ,
				sinX * sinZ - cosX * sinY * cosZ,
				0));
			matrix.SetColumn(1, new Vector4(
				-cosY * sinZ,
				cosX * cosZ - sinX * sinY * sinZ,
				sinX * cosZ + cosX * sinY * sinZ,
				0));
			matrix.SetColumn(2, new Vector4(
				sinY,
				-sinX * cosY,
				cosX * cosY,
				0));
			matrix.SetColumn(3, new Vector4(0, 0, 0, 1));
			return matrix;
		}
	}
}