//=========================================
//Author: 洪金敏
//Email: jonny.hong91@gmail.com
//Create Date: 2021-01-03 16:05:00
//Description: 
//=========================================

using UnityEngine;

public class CameraTransformation : Transformation
{
	public float FocalLength = 2;
	public override Matrix4x4 Matrix
	{
		get
		{
			var matrix = new Matrix4x4();
			matrix.SetRow(0, new Vector4(FocalLength, 0, 0, 0));
			matrix.SetRow(1, new Vector4(0, FocalLength, 0, 0));
			matrix.SetRow(2, new Vector4(0, 0, 0, 0));
			matrix.SetRow(3, new Vector4(0, 0, 1, 0));
			return matrix;
		}
	}
}