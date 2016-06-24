// -----------------------------------------------------------------------------
// unit-test_lowlevel.as
// nandOS
// Created by Stjepan Stamenkovic.
// -----------------------------------------------------------------------------

// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
// 
// This file serves as a substitute for a proper API documentation for the time
// being. It is supposed to properly interact with the binary kernel and system
// API and should be using the correct firmware control/interrupt codes.
//
// THE SPECIFICATION OF nandOS IS IN FLUX, JOIN THE CONVERSATION AT:
//
//     https://3001sq.net/forums/#/categories/nandos-design
//
// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

// Application class for template type tests
class AppClass
{
	// -----------------------------------------------------
	// Private
	// -----------------------------------------------------

	private int m_Private;
	
	// -----------------------------------------------------
	// Protected
	// -----------------------------------------------------
	
	protected int m_Protected;
	
	// -----------------------------------------------------
	// Public
	// -----------------------------------------------------
	
	int value;
	
	// ---------------------------------
	
	AppClass()
	{
		value = 0;
	}
	
	AppClass(int v)
	{
		value = v;
	}
	
	string opImplConv() const 
	{
		return string("(AppClass) value: " + value); 
	}
}

// Emulation of static functions by a namespace of the same name
namespace AppClass
{
	void DumpVector(AppClass[] &in v)
	{
		log("Vector: " + v.size() + " objects");
		for (uint i = 0; i < v.size(); i++)
		{
			log(" " + v[i]);
		}
	}
}

// -----------------------------------------------------------------------------
// Test functions
// -----------------------------------------------------------------------------

void testOutput()
{
	log("=== Output");

	for (int i = 0; i < 5; i++)
	{
		log("AngelScript output test");
	}
}

void testStringType()
{
	log("=== String types");

	log("-- Construction");

	{
		string sEmpty;
		log(sEmpty);

		string sValue("string value");
		log(sValue);
	}

	{
		string s0("level 0");
		log(s0);
		{
			string s1("level 1");
			log(s1);
			{
				string s2("level 2");
				log(s2);
			}
		}
	}

	log("-- Assignment");

	{
		string a = "first value";
		string b = "second value";
		log(a);
		log(b);

		a = b;
		log(a);
		log(b);
	}
	
	log("-- Concatenation");
	
	{
		string s1 = "first";
		string s2 = "second";
		
		log(s1 + s2);
		log(s1 + s1 + s1);
		log(s1 + ", " + s2);
		
		log("test constant " + "test constant2");
	}

	log("-- Type conversions");

	{
		log("bool - " + true);
		log(false + " - bool");
		
		log(12 + " - int");
		log("int - " + 34);
		
		log(12.3 + " - float");
		log("float - " + 45.6);
		
		log("vec2 - " + vec2(1, 2));
		log("vec3 - " + vec3(1, 2, 3));
		log("vec4 - " + vec4(1, 2, 3, 4));
		log("quat - " + quat(1, 2, 3, 4));
	}

	log("-- Specific methods");
	
	// TODO
}

void testVectorTypes()
{
	{
		log("=== Vector2");

		log("-- Construction");

		{
			vec2 vEmpty;
			log("Empty: " + vEmpty);

			vec2 vValue(1.0, 2.0);
			log("Value: " + vValue);

			vec2 vValueDerived(vValue);
			log("ValueDerived: " + vValueDerived);
		}

		{
			vec2 v0(2.0, 3.0);
			log("v0: " + v0);
			{
				vec2 v1(3.0, 4.0);
				log("v1: " + v1);
				{
					vec2 v2(4.0, 5.0);
					log("v2: " + v2);
				}
			}
		}

		log("-- Component access");

		{
			vec2 v(1.0, 2.0);
			log("x: " + string(v.x));
			log("y: " + string(v.y));
		}

		log("-- Assignment");
		
		{
			vec2 vA = vec2(1.1, 2.2);
			vec2 vB = vec2(2.2, 3.3);
			vA = vB;
			
			log("vA: " + vA);
			log("vB: " + vB);
		}

		{
			vec2 vA(2.2, 4.4);
			
			log("vA: " + vA);

			vec2 vB1(0.0, 0.0);
			vec2 vB2(0.0, 0.0);
			vec2 vB3(1.0, 1.0);
			vec2 vB4(1.0, 1.0);
			
			log("vB1: " + vB1);
			log("vB2: " + vB2);
			log("vB3: " + vB3);
			log("vB4: " + vB4);

			vB1 += vA;
			vB2 -= vA;
			vB3 *= vA;
			vB4 /= vA;
			
			log("+= " + vB1);
			log("-= " + vB2);
			log("*= " + vB3);
			log("/= " + vB4);
		}

		log("-- Binary operators");

		{
			vec2 vA(5.0, 6.0);
			vec2 vB(3.1, 2.2);
			log("vA: " + vA);
			log("vB: " + vB);
			log("vA + vB: " + (vA + vB));
			log("vA - vB: " + (vA - vB));
			log("vA * vB: " + (vA * vB));
			log("vA / vB: " + (vA / vB));

			float s = 1.3;
			log("vA * s: " + (vA * s));
			log("s * vA: " + (s * vA));
		}

		log("-- Type conversions");

		{
			vec2 v(1.0, 2.0);
			log("v: " + string(v));
		}

		log("-- Specific methods");

		{
			vec2 v(1.0, 2.0);
			log("l: " + length(v));
			log("abs: " + abs(v));
			log("norm: " + normalize(v));
		}
	}

	// ------------------------------------
	
	{
		log("=== Vector3");

		log("-- Construction");

		{
			vec3 vEmpty;
			log("Empty: " + vEmpty);

			vec3 vValue(1.0, 2.0, 3.0);
			log("Value: " + vValue);

			vec3 vValueDerived(vValue);
			log("ValueDerived: " + vValueDerived);
			
			vec3 vValueList = {2.0, 3.0, 4.0};
			log("ValueList: " + vValueList);
		}

		{
			vec3 v0(2.0, 3.0, 4.0);
			log("v0: " + v0);
			{
				vec3 v1(3.0, 4.0, 5.0);
				log("v1: " + v1);
				{
					vec3 v2(4.0, 5.0, 6.0);
					log("v2: " + v2);
				}
			}
		}

		log("-- Component access");

		{
			vec3 v(1.0, 2.0, 3.0);
			log("x: " + string(v.x));
			log("y: " + string(v.y));
			log("z: " + string(v.z));
		}

		log("-- Assignment");
		
		{
			vec3 vA = vec3(1.1, 2.2, 3.3);
			vec3 vB = vec3(2.2, 3.3, 4.4);
			vA = vB;
			
			log("vA: " + vA);
			log("vB: " + vB);
		}

		{
			vec3 vA(2.2, 4.4, 3.3);
			
			log("vA: " + vA);

			vec3 vB1(0.0, 0.0, 0.0);
			vec3 vB2(0.0, 0.0, 0.0);
			vec3 vB3(1.0, 1.0, 1.0);
			vec3 vB4(1.0, 1.0, 1.0);
			
			log("vB1: " + vB1);
			log("vB2: " + vB2);
			log("vB3: " + vB3);
			log("vB4: " + vB4);

			vB1 += vA;
			vB2 -= vA;
			vB3 *= vA;
			vB4 /= vA;
			
			log("+= " + vB1);
			log("-= " + vB2);
			log("*= " + vB3);
			log("/= " + vB4);
		}

		log("-- Binary operators");

		{
			vec3 vA(5.0, 6.0, 4.0);
			vec3 vB(3.1, 2.2, 1.1);
			log("vA: " + vA);
			log("vB: " + vB);
			log("vA + vB: " + (vA + vB));
			log("vA - vB: " + (vA - vB));
			log("vA * vB: " + (vA * vB));
			log("vA / vB: " + (vA / vB));

			float s = 1.3;
			log("vA * s: " + (vA * s));
			log("s * vA: " + (s * vA));
		}

		log("-- Type conversions");

		{
			vec3 v(1.0, 2.0, 3.0);
			log("v: " + string(v));
		}

		log("-- Specific methods");

		{
			vec3 v1(1.0, 2.0, 3.0);
			log("l: " + length(v1));
			log("abs: " + abs(v1));
			log("norm: " + normalize(v1));
			
			log("dot: " + string(dot(vec3(1.0, 0.0, 2.0), vec3(2.0, 3.0, 4.0))));
			log("cross: " + cross(vec3(2.0, 0, 0), vec3(0, 3.0, 0)));
		}
	}

	// ------------------------------------
	
	{
		log("=== Vector4");

		log("-- Construction");

		{
			vec4 vEmpty;
			log("Empty: " + vEmpty);

			vec4 vValue(1.0, 2.0, 3.0, 4.0);
			log("Value: " + vValue);

			vec4 vValueDerived(vValue);
			log("ValueDerived: " + vValueDerived);
			
			vec4 vValueList = {2.0, 3.0, 4.0, 5.0};
			log("ValueList: " + vValueList);
		}

		{
			vec4 v0(2.0, 3.0, 4.0, 5.0);
			log("v0: " + v0);
			{
				vec4 v1(3.0, 4.0, 5.0, 6.0);
				log("v1: " + v1);
				{
					vec4 v2(4.0, 5.0, 6.0, 7.0);
					log("v2: " + v2);
				}
			}
		}

		log("-- Component access");

		{
			vec4 v(1.0, 2.0, 3.0, 4.0);
			log("x: " + string(v.x));
			log("y: " + string(v.y));
			log("z: " + string(v.z));
			log("w: " + string(v.w));
		}

		log("-- Assignment");
		
		{
			vec4 vA = vec4(1.1, 2.2, 3.3, 4.4);
			vec4 vB = vec4(2.2, 3.3, 4.4, 5.5);
			vA = vB;
			
			log("vA: " + vA);
			log("vB: " + vB);
		}

		{
			vec4 vA(2.2, 4.4, 3.3, 4.4);
			
			log("vA: " + vA);

			vec4 vB1(0.0, 0.0, 0.0, 0.0);
			vec4 vB2(0.0, 0.0, 0.0, 0.0);
			vec4 vB3(1.0, 1.0, 1.0, 1.0);
			vec4 vB4(1.0, 1.0, 1.0, 1.0);
			
			log("vB1: " + vB1);
			log("vB2: " + vB2);
			log("vB3: " + vB3);
			log("vB4: " + vB4);

			vB1 += vA;
			vB2 -= vA;
			vB3 *= vA;
			vB4 /= vA;
			
			log("+= " + vB1);
			log("-= " + vB2);
			log("*= " + vB3);
			log("/= " + vB4);
		}

		log("-- Binary operators");

		{
			vec4 vA(5.0, 6.0, 4.0, 5.0);
			vec4 vB(3.1, 2.2, 1.1, 3.2);
			log("vA: " + vA);
			log("vB: " + vB);
			log("vA + vB: " + (vA + vB));
			log("vA - vB: " + (vA - vB));
			log("vA * vB: " + (vA * vB));
			log("vA / vB: " + (vA / vB));
		}

		log("-- Type conversions");

		{
			vec4 v(1.0, 2.0, 3.0, 4.0);
			log("v: " + string(v));
		}

		log("-- Specific methods");

		{
			vec4 v(1.0, 2.0, 3.0, 4.0);
			log("l: " + length(v));
			log("abs: " + abs(v));
			log("norm: " + normalize(v));
		}
	}
}

void testQuaternionType()
{
	{
		log("=== Quaternion");

		log("-- Construction");

		{
			quat qEmpty;
			log("Empty: " + qEmpty);

			quat qValue(1.0, 2.0, 3.0, 4.0);
			log("Value: " + qValue);

			quat qValueDerived(qValue);
			log("ValueDerived: " + qValueDerived);
			
			quat qValueList = {2.0, 3.0, 4.0, 5.0};
			log("ValueList: " + qValueList);
		}

		{
			quat q0(2.0, 3.0, 4.0, 5.0);
			log("q0: " + q0);
			{
				quat q1(3.0, 4.0, 5.0, 6.0);
				log("q1: " + q1);
				{
					quat q2(4.0, 5.0, 6.0, 7.0);
					log("q2: " + q2);
				}
			}
		}

		log("-- Component access");

		{
			quat q(1.0, 2.0, 3.0, 4.0);
			log("w: " + string(q.w));
			log("x: " + string(q.x));
			log("y: " + string(q.y));
			log("z: " + string(q.z));
		}

		log("-- Assignment");
		
		{
			quat qA = quat(1.1, 2.2, 3.3, 4.4);
			quat qB = quat(2.2, 3.3, 4.4, 5.5);
			qA = qB;
			
			log("qA: " + qA);
			log("qB: " + qB);
		}

		{
			quat qA(2.2, 4.4, 3.3, 4.4);
			
			log("qA: " + qA);

			quat qB1(0.0, 0.0, 0.0, 0.0);
			quat qB2(1.0, 1.0, 1.0, 1.0);
			
			log("qB1: " + qB1);
			log("qB2: " + qB2);

			qB1 += qA;
			qB2 *= qA;
			
			log("+= " + qB1);
			log("*= " + qB2);
		}

		log("-- Binary operators");

		{
			quat qA(5.0, 6.0, 4.0, 5.0);
			quat qB(3.1, 2.2, 1.1, 3.2);
			log("qA: " + qA);
			log("qB: " + qB);
			log("qA + qB: " + (qA + qB));
			log("qA * qB: " + (qA * qB));
		}

		log("-- Type conversions");

		{
			quat q(1.0, 2.0, 3.0, 4.0);
			log("q: " + string(q));
		}

		log("-- Specific methods");

		{
			quat q(1.0, 2.0, 3.0, 4.0);
			log("l: " + length(q));
			log("norm: " + normalize(q));
		}
	}
}

void testMatrixTypes()
{
}

void _assignVar(var &out v)
{
	v = var(123);
}

void testVariantType()
{
	{
		log("=== Variant");
		
		log("-- Construction");

		{
			var vEmpty;
			
			var vValue(123);
			log("Value: " + int(vValue));
			
			var vValueDerived(vValue);
			log("ValueDerived: " + int(vValueDerived));
		}
		
		log("-- Construct from type");
		
		{
			log("Bool: " + bool(var(true)));
			log("Int: " + int(var(123)));
			log("Float: " + float(var(45.6)));
			log("Vec2: " + vec2(var(vec2(1, 2))));
			log("Vec3: " + vec3(var(vec3(1, 2, 3))));
			log("Vec4: " + vec4(var(vec4(1, 2, 3, 4))));
			log("Quat: " + quat(var(quat(1, 2, 3, 4))));
			log("String: " + string(var("string value")));
		}
		
		log("-- Assignment");
		
		{
			var v(123);
			var vOther = v;
			log("Other: " + vOther.dump());
			
			v = false;
			log("Bool: " + v.dump());
			v = 123;
			log("Int: " + v.dump());
			v = 1.23;
			log("Float: " + v.dump());
			v = vec2(1.0, 2.0);
			log("Vec2: " + v.dump());
			v = vec3(1.0, 2.0, 3.0);
			log("Vec3: " + v.dump());
			v = vec4(1.0, 2.0, 3.0, 4.0);
			log("Vec4: " + v.dump());
			v = quat(1.0, 2.0, 3.0, 4.0);
			log("Quat: " + v.dump());
			v = "test";
			log("String: " + v.dump());
		}
		
		log("-- Reference passing");
		
		{
			var v;
			_assignVar(v);
			log("Reference: " + v.dump());
		}
		
		log("-- Data type enums");
		
		{
			log("Undefined: " + VariantData_Type_Undefined);
			log("Bool: " + VariantData_Type_Bool);
			log("Float: " + VariantData_Type_Float);
			log("Integer: " + VariantData_Type_Integer);
			log("Unsigned: " + VariantData_Type_Unsigned);
			log("String: " + VariantData_Type_String);
			log("Text: " + VariantData_Type_Text);
			log("Vector2: " + VariantData_Type_Vector2);
			log("Vector3: " + VariantData_Type_Vector3);
			log("Vector4: " + VariantData_Type_Vector4);
			log("Quaternion: " + VariantData_Type_Quaternion);
			
			log("Int var type: " + var(123).getType());
		}
		
		log("-- Dump");
		
		{
			var v(123.456);
			log("Dump: " + v.dump());
		}
	}
}

// ---------------------------------------------------------

void dumpVector(const vector<bool> &in v)
{
	for (uint i = 0; i < v.size(); i++)
	{
		if (v[i])
		{
			log("true");
		}
		else
		{
			log("false");
		}
	}
}

void dumpVector(const vector<int8> &in v)
{
	for (uint i = 0; i < v.size(); i++)
	{
		log(v[i]);
	}
}

void dumpVector(const vector<uint8> &in v)
{
	for (uint i = 0; i < v.size(); i++)
	{
		log(v[i]);
	}
}

void dumpVector(const vector<int16> &in v)
{
	for (uint i = 0; i < v.size(); i++)
	{
		log(v[i]);
	}
}

void dumpVector(const vector<uint16> &in v)
{
	for (uint i = 0; i < v.size(); i++)
	{
		log(v[i]);
	}
}

void dumpVector(const vector<int> &in v)
{
	for (uint i = 0; i < v.size(); i++)
	{
		log(v[i]);
	}
}

void dumpVector(const vector<uint> &in v)
{
	for (uint i = 0; i < v.size(); i++)
	{
		log(v[i]);
	}
}

void dumpVector(const vector<int64> &in v)
{
	for (uint i = 0; i < v.size(); i++)
	{
		log(v[i]);
	}
}

void dumpVector(const vector<uint64> &in v)
{
	for (uint i = 0; i < v.size(); i++)
	{
		log(v[i]);
	}
}

void dumpVector(const vector<float> &in v)
{
	for (uint i = 0; i < v.size(); i++)
	{
		log(v[i]);
	}
}

void dumpVector(const vector<double> &in v)
{
	for (uint i = 0; i < v.size(); i++)
	{
		log(v[i]);
	}
}

void dumpVector(const vector<var> &in v)
{
	for (uint i = 0; i < v.size(); i++)
	{
		log(v[i]);
	}
}

void dumpVector(const AppClass[] &in v)
{
	for (uint i = 0; i < v.size(); i++)
	{
		log(v[i]);
	}
}

// ---------------------------------------------------------

void testContainerTypes()
{
	log("=== Vector");

	{
		log("-- Element Assignment");
		
		{
			vector<bool> v(2);
			v[0] = true;
			v[1] = false;
			dumpVector(v);
		}
		
		{
			vector<int8> v(2);
			v[0] = -1;
			v[1] = 2;
			dumpVector(v);
		}
		
		{
			vector<uint8> v(2);
			v[0] = 1;
			v[1] = 2;
			dumpVector(v);
		}
		
		{
			vector<int16> v(2);
			v[0] = -1;
			v[1] = 2;
			dumpVector(v);
		}
		
		{
			vector<uint16> v(2);
			v[0] = 1;
			v[1] = 2;
			dumpVector(v);
		}
		
		{
			vector<int> v(2);
			v[0] = -1;
			v[1] = 2;
			dumpVector(v);
		}
		
		{
			vector<uint> v(2);
			v[0] = 1;
			v[1] = 2;
			dumpVector(v);
		}
		
		{
			vector<int64> v(2);
			v[0] = -1;
			v[1] = 2;
			dumpVector(v);
		}
		
		{
			vector<uint64> v(2);
			v[0] = 1;
			v[1] = 2;
			dumpVector(v);
		}
		
		{
			vector<float> v(2);
			v[0] = -1.1;
			v[1] = 2.2;
			dumpVector(v);
		}
		
		{
			vector<double> v(2);
			v[0] = -1.1;
			v[1] = 2.2;
			dumpVector(v);
		}
		
		{
			vector<var> v(4);
			v[0] = false;
			v[1] = 1;
			v[2] = -2.2;
			v[3] = "teststring";
			dumpVector(v);
		}
		
		log("-- Assignment");
		
		{
			vector<int> v1(2);
			vector<int> v2(2);
			v1[0] = -1;
			v1[1] = 2;
			v2 = v1;
			dumpVector(v1);
			dumpVector(v2);
		}
		
		log("-- List constructor");
		
		{
			vector<bool> v = {true, false};
			dumpVector(v);
		}
		
		{
			vector<int8> v = {-1, 2};
			dumpVector(v);
		}
		
		{
			vector<uint8> v = {1, 2};
			dumpVector(v);
		}
		
		{
			vector<int16> v = {-1, 2};
			dumpVector(v);
		}
		
		{
			vector<uint16> v = {1, 2};
			dumpVector(v);
		}
		
		{
			vector<int> v = {-1, 2};
			dumpVector(v);
		}
		
		{
			vector<uint> v = {1, 2};
			dumpVector(v);
		}
		
		{
			vector<int64> v = {-1, 2};
			dumpVector(v);
		}
		
		{
			vector<uint64> v = {1, 2};
			dumpVector(v);
		}
		
		{
			vector<float> v = {-1.1, 2.2};
			dumpVector(v);
		}
		
		{
			vector<double> v = {-1.1, 2.2};
			dumpVector(v);
		}
		
		{
			vector<var> v = {false, 1, -2.2, "teststring"};
			dumpVector(v);
		}
		
		log("-- Standard functions");
		
		{
			vector<int> v = {0};
			log("Empty " + v.empty() + " size " + v.size());
			v.clear();
			log("Empty " + v.empty() + " size " + v.size());
			v.push_back(-1);
			v.push_back(2);
			log("Empty " + v.empty() + " size " + v.size());
			dumpVector(v);
			v.pop_back();
			dumpVector(v);
			v.insert(0, -2);
			v.insert(0, -3);
			v.insert(1, 0);
			dumpVector(v);
			v.erase(2);
			dumpVector(v);
		}
		
		{
			vector<var> v = {0};
			log("Empty " + v.empty() + " size " + v.size());
			v.clear();
			log("Empty " + v.empty() + " size " + v.size());
			v.push_back(-1);
			v.push_back(2);
			log("Empty " + v.empty() + " size " + v.size());
			dumpVector(v);
			v.pop_back();
			dumpVector(v);
			v.insert(0, -2);
			v.insert(0, -3);
			v.insert(1, 0);
			dumpVector(v);
			v.erase(2);
			dumpVector(v);
		}
		
		log("-- Default array snytax");
		
		{
			int[] ints = {1, 2, 3};
			dumpVector(ints);
		}
		
		{
			var[] vars = {1, 2, 3};
			dumpVector(vars);
		}
		
		{
			// Doesn't work:
			// var vars[5];
			// dumpVector(vars);
		}
		
		log("-- Application class array");

		log("- Constructor");
		
		{
			AppClass[] objects;
			AppClass::DumpVector(objects);
		}
		
		log("- Constructor(uint)");
		
		{
			AppClass[] objects(3);
			AppClass::DumpVector(objects);
		}
		
		log("- Constructor(list)");
		
		{
			AppClass[] objects = { AppClass(1), AppClass(2), AppClass(3) };
			AppClass::DumpVector(objects);
		}
	
		// log("Copy-Constructor, assignment");
		
		{
			// TODO
			// AppClass[] objects = { AppClass(1), AppClass(2), AppClass(3) };
			// AppClass[] objectsCopy(objects);
			// AppClass::DumpVector(objectsCopy);
		}

		log("- operator=()");
		
		{
			AppClass[] objects = { AppClass(1), AppClass(2), AppClass(3) };
			AppClass[] objectsAssign;
			objectsAssign = objects;
			AppClass::DumpVector(objectsAssign);
		}
		
		log("- empty()");
		
		{
			AppClass[] objects;
			log(objects.empty());
			objects.push_back(AppClass(1));
			log(objects.empty());
		}
		
		log("- size()");
		
		{
			AppClass[] objects = { AppClass(1), AppClass(2), AppClass(3) };
			log(objects.size());
		}
		
		log("- clear()");
		
		{
			AppClass[] objects = { AppClass(1), AppClass(2), AppClass(3) };
			objects.clear();
			AppClass::DumpVector(objects);
		}
		
		log("- push_back()");
		
		{
			AppClass[] objects = { AppClass(1), AppClass(2), AppClass(3) };
			objects.push_back(AppClass(4));
			AppClass::DumpVector(objects);
		}
		
		log("- pop_back()");
		
		{
			AppClass[] objects = { AppClass(1), AppClass(2), AppClass(3) };
			objects.pop_back();
			AppClass::DumpVector(objects);
		}
		
		log("- insert()");
		
		{
			AppClass[] objects = { AppClass(1), AppClass(2), AppClass(3) };
			objects.insert(1, AppClass(0));
			AppClass::DumpVector(objects);
		}
		
		log("- erase()");
		
		{
			AppClass[] objects = { AppClass(1), AppClass(2), AppClass(3) };
			objects.erase(1);
			AppClass::DumpVector(objects);
		}
		
		log("-- Exceptions");
		
		{
			vector<int> v = {-1 ,1};
			// v[2] = 10;
			// int i = v[2];
			// v.insert(2, -10);
			// v.erase(2);
		}
		
		{
			vector<var> v = {-1 ,1};
			// v[2] = 10;
			// int i = v[2];
			// v.insert(2, -10);
			// v.erase(2);
		}
		
		{
			// Failed private/protected property access
			// AppClass obj;
			// obj.m_Private = 10;
			// obj.m_Protected = 12;
		}
	}
}

// -----------------------------------------------------------------------------
// Entry point for interface tests
// -----------------------------------------------------------------------------

void unittest()
{
	log("===== STARTING UNITTEST =====");

	// --------------------------------------------------------
	// Basic I/O system calls
	// --------------------------------------------------------
	
	testOutput();

	// --------------------------------------------------------
	// Types
	// --------------------------------------------------------

	// Strings
	testStringType();

	// Geometry types
	testVectorTypes();
	testQuaternionType();
	testMatrixTypes();
	
	// Variant type
	testVariantType();
	
	// Container types
	testContainerTypes();
	
	// --------------------------------------------------------
	
	log("=====  ENDING UNITTEST  =====");
}
